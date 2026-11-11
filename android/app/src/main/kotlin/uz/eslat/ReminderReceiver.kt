package uz.eslat

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

/** Vaqti kelganda: budilnik yoki bildirishnoma + (kerak bo'lsa) avtomatik tabrik SMS. */
class ReminderReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val reminder = ReminderScheduler.find(context, ReminderScheduler.reminderId(intent)) ?: return
        val ringing = reminder.alarm && try {
            AlarmService.start(context, reminder.title, reminder.body, reminder.route)
            true
        } catch (e: Exception) {
            false // fon xizmati taqiqlangan bo'lsa — oddiy bildirishnoma
        }
        if (!ringing) {
            Notifier.show(context, reminder.id, reminder.title, reminder.body, reminder.route)
        }
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
