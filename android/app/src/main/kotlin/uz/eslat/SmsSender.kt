package uz.eslat

import android.Manifest
import android.app.Activity
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.telephony.SmsManager

/**
 * Tabrik SMS'ni foydalanuvchining o'z SIM kartasidan yuboradi (bepul, uning
 * raqamidan). Natija (yuborildi / yuborilmadi) bildirishnoma bilan ko'rsatiladi.
 */
object SmsSender {
    private const val RESULT_ID_FLAG = 0x40000000

    fun send(context: Context, r: Reminder) {
        val resultId = r.id xor RESULT_ID_FLAG
        if (context.checkSelfPermission(Manifest.permission.SEND_SMS) !=
            PackageManager.PERMISSION_GRANTED
        ) {
            Notifier.show(context, resultId, r.smsFailedTitle ?: "SMS", r.smsPhone.orEmpty(), r.route)
            return
        }
        try {
            val sms = if (Build.VERSION.SDK_INT >= 31) {
                context.getSystemService(SmsManager::class.java)
            } else {
                @Suppress("DEPRECATION")
                SmsManager.getDefault()
            }
            val result = Intent(context, SmsResultReceiver::class.java)
                .putExtra("notificationId", resultId)
                .putExtra("sentTitle", r.smsSentTitle)
                .putExtra("failedTitle", r.smsFailedTitle)
                .putExtra("phone", r.smsPhone)
                .putExtra("route", r.route)
            val sent = PendingIntent.getBroadcast(
                context, resultId, result,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
            )
            val parts = sms.divideMessage(r.smsText)
            val sentIntents = ArrayList<PendingIntent>().apply { repeat(parts.size) { add(sent) } }
            sms.sendMultipartTextMessage(r.smsPhone, null, parts, sentIntents, null)
        } catch (e: Exception) {
            Notifier.show(context, resultId, r.smsFailedTitle ?: "SMS", r.smsPhone.orEmpty(), r.route)
        }
    }
}

class SmsResultReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val sent = resultCode == Activity.RESULT_OK
        val title = intent.getStringExtra(if (sent) "sentTitle" else "failedTitle") ?: return
        Notifier.show(
            context,
            intent.getIntExtra("notificationId", 0),
            title,
            intent.getStringExtra("phone").orEmpty(),
            intent.getStringExtra("route"),
        )
    }
}
