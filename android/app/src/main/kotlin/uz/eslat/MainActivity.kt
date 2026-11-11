package uz.eslat

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.provider.ContactsContract.CommonDataKinds.Phone
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/**
 * Flutter <-> Android ko'prigi ("uz.eslat/native"):
 *  - syncReminders: eslatmalarni (va avtomatik SMS'ni) AlarmManager'ga yozish
 *  - requestPermission: "sms" yoki "notifications" ruxsatini so'rash
 *  - openAppSettings: ilovaning telefon sozlamalaridagi sahifasini ochish
 *    (APK'dan o'rnatilganda SMS ruxsati "cheklangan sozlama" bo'ladi)
 *  - pickContact: tizim oynasidan bitta kontakt raqamini olish
 *    (ilova butun kontaktlar ro'yxatini O'QIMAYDI — READ_CONTACTS kerak emas)
 */
class MainActivity : FlutterActivity() {
    private var pendingContact: MethodChannel.Result? = null
    private var pendingPermission: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "syncReminders" -> {
                        val raw = call.argument<List<Map<String, Any?>>>("reminders").orEmpty()
                        ReminderScheduler.sync(this, raw.map(Reminder::fromMap))
                        result.success(null)
                    }
                    "requestPermission" -> requestPermission(call.argument("name"), result)
                    "openAppSettings" -> {
                        startActivity(
                            Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS)
                                .setData(Uri.fromParts("package", packageName, null))
                                .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK),
                        )
                        result.success(null)
                    }
                    "pickContact" -> pickContact(result)
                    else -> result.notImplemented()
                }
            }
    }

    private fun requestPermission(name: String?, result: MethodChannel.Result) {
        val permission = when (name) {
            "sms" -> Manifest.permission.SEND_SMS
            "notifications" ->
                if (Build.VERSION.SDK_INT >= 33) Manifest.permission.POST_NOTIFICATIONS else null
            else -> return result.error("unknown_permission", name, null)
        }
        if (permission == null ||
            checkSelfPermission(permission) == PackageManager.PERMISSION_GRANTED
        ) {
            return result.success(true)
        }
        // Boshqa ruxsat oynasi ochiq bo'lsa — kutmasdan joriy holatni qaytaramiz.
        if (pendingPermission != null) return result.success(false)
        pendingPermission = result
        requestPermissions(arrayOf(permission), REQUEST_PERMISSION)
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode != REQUEST_PERMISSION) return
        pendingPermission?.success(
            grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED,
        )
        pendingPermission = null
    }

    private fun pickContact(result: MethodChannel.Result) {
        if (pendingContact != null) return result.error("busy", null, null)
        pendingContact = result
        try {
            startActivityForResult(Intent(Intent.ACTION_PICK, Phone.CONTENT_URI), REQUEST_CONTACT)
        } catch (e: Exception) {
            pendingContact = null
            result.success(null)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode != REQUEST_CONTACT) return
        val result = pendingContact ?: return
        pendingContact = null
        val uri = data?.data
        if (resultCode != Activity.RESULT_OK || uri == null) return result.success(null)
        try {
            contentResolver.query(uri, arrayOf(Phone.DISPLAY_NAME, Phone.NUMBER), null, null, null)
                ?.use { cursor ->
                    if (cursor.moveToFirst()) {
                        return result.success(
                            mapOf("name" to cursor.getString(0), "phone" to cursor.getString(1)),
                        )
                    }
                }
            result.success(null)
        } catch (e: Exception) {
            result.success(null)
        }
    }

    companion object {
        const val CHANNEL = "uz.eslat/native"
        private const val REQUEST_CONTACT = 4101
        private const val REQUEST_PERMISSION = 4102
    }
}
