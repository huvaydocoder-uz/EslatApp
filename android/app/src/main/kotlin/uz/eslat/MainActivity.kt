package uz.eslat

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.media.MediaPlayer
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.provider.ContactsContract.CommonDataKinds.Phone
import android.provider.OpenableColumns
import android.view.WindowManager
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
 *  - alarmSound / pickAlarmSound / resetAlarmSound / previewAlarmSound /
 *    stopAlarm: budilnik musiqasi (telefon xotirasidan) va uni to'xtatish
 *    (ilova butun kontaktlar ro'yxatini O'QIMAYDI — READ_CONTACTS kerak emas)
 */
class MainActivity : FlutterActivity() {
    private var pendingContact: MethodChannel.Result? = null
    private var pendingPermission: MethodChannel.Result? = null
    private var pendingSound: MethodChannel.Result? = null
    private var preview: MediaPlayer? = null
    private val handler = Handler(Looper.getMainLooper())

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        showOverLockScreenForAlarm(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        showOverLockScreenForAlarm(intent)
    }

    /** Budilnik ochganda — qulflangan ekran ustida ko'rinadi va ekranni yoqadi. */
    private fun showOverLockScreenForAlarm(intent: Intent?) {
        if (intent?.data?.path?.startsWith("/alarm/") != true) return
        if (Build.VERSION.SDK_INT >= 27) {
            setShowWhenLocked(true)
            setTurnScreenOn(true)
        } else {
            @Suppress("DEPRECATION")
            window.addFlags(
                WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED or
                    WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON,
            )
        }
    }

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
                    "alarmSound" -> result.success(AlarmSound.name(this))
                    "pickAlarmSound" -> pickAlarmSound(result)
                    "resetAlarmSound" -> {
                        AlarmSound.reset(this)
                        result.success(null)
                    }
                    "previewAlarmSound" -> {
                        previewAlarmSound(call.argument<Boolean>("play") == true)
                        result.success(null)
                    }
                    "stopAlarm" -> {
                        AlarmService.stop(this)
                        result.success(null)
                    }
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

    private fun pickAlarmSound(result: MethodChannel.Result) {
        if (pendingSound != null) return result.error("busy", null, null)
        pendingSound = result
        val intent = Intent(Intent.ACTION_OPEN_DOCUMENT)
            .addCategory(Intent.CATEGORY_OPENABLE)
            .setType("audio/*")
        try {
            startActivityForResult(intent, REQUEST_SOUND)
        } catch (e: Exception) {
            pendingSound = null
            result.success(null)
        }
    }

    private fun onAlarmSoundPicked(resultCode: Int, data: Intent?) {
        val result = pendingSound ?: return
        pendingSound = null
        val uri = data?.data
        if (resultCode != Activity.RESULT_OK || uri == null) return result.success(null)
        try {
            val name = contentResolver.query(uri, arrayOf(OpenableColumns.DISPLAY_NAME), null, null, null)
                ?.use { if (it.moveToFirst()) it.getString(0) else null }
                ?: uri.lastPathSegment ?: "♪"
            AlarmSound.save(this, uri, name.substringBeforeLast('.'))
            result.success(AlarmSound.name(this))
        } catch (e: Exception) {
            result.success(null)
        }
    }

    /** Tanlangan musiqani 10 soniya tinglab ko'rish. */
    private fun previewAlarmSound(play: Boolean) {
        handler.removeCallbacksAndMessages(null)
        preview?.release()
        preview = null
        if (!play) return
        preview = AlarmSound.createPlayer(this, looping = false)?.also { it.start() }
        handler.postDelayed({ previewAlarmSound(false) }, 10_000)
    }

    override fun onDestroy() {
        previewAlarmSound(false)
        super.onDestroy()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUEST_SOUND) return onAlarmSoundPicked(resultCode, data)
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
        private const val REQUEST_SOUND = 4103
    }
}
