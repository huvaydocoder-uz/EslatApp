package uz.eslat

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

/** Vaqti kelganda: bildirishnoma + (kerak bo'lsa) avtomatik tabrik SMS. */
class ReminderReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val reminder = ReminderScheduler.find(context, ReminderScheduler.reminderId(intent)) ?: return
        Notifier.show(context, reminder.id, reminder.title, reminder.body, reminder.route)
        if (reminder.hasSms) SmsSender.send(context, reminder)
        ReminderScheduler.afterFired(context, reminder)
    }
}

/** Telefon qayta yoqilganda yoki ilova yangilanganda eslatmalarni tiklaydi. */
class BootReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        when (intent.action) {
            Intent.ACTION_BOOT_COMPLETED,
            Intent.ACTION_MY_PACKAGE_REPLACED,
            "android.intent.action.QUICKBOOT_POWERON" -> ReminderScheduler.restore(context)
        }
    }
}
