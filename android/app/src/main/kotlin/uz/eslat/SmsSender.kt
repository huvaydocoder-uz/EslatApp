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
import android.telephony.SubscriptionManager

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
            val sms = smsManager(context)
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

    /**
     * Ikki SIM kartali telefonlar: SMS uchun tanlangan SIM; "har safar so'rash"
     * rejimida — asosiy SIM. Aks holda fon rejimida SMS ketmay qolishi mumkin.
     */
    private fun smsManager(context: Context): SmsManager {
        val invalid = SubscriptionManager.INVALID_SUBSCRIPTION_ID
        val subId = SubscriptionManager.getDefaultSmsSubscriptionId().takeIf { it != invalid }
            ?: SubscriptionManager.getDefaultSubscriptionId()
        return if (Build.VERSION.SDK_INT >= 31) {
            val base = context.getSystemService(SmsManager::class.java)
            if (subId != invalid) base.createForSubscriptionId(subId) else base
        } else {
            @Suppress("DEPRECATION")
            if (subId != invalid) {
                SmsManager.getSmsManagerForSubscriptionId(subId)
            } else {
                SmsManager.getDefault()
            }
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
