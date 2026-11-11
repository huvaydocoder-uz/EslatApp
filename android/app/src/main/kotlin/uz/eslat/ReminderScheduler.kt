package uz.eslat

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import org.json.JSONArray
import java.util.Calendar

/**
 * Eslatmalarni AlarmManager orqali aniq vaqtga qo'yadi va telefonda saqlaydi
 * (qayta yoqilganda tiklash uchun). Ilova yopiq bo'lsa ham ishlaydi.
 */
object ReminderScheduler {
    private const val PREFS = "eslat_reminders"
    private const val KEY = "items"
    private const val EXTRA_ID = "reminder_id"
    private const val MISSED_GRACE_MS = 12 * 60 * 60 * 1000L

    /** Eskilarini bekor qilib, yangi ro'yxatni rejalashtiradi. */
    fun sync(context: Context, reminders: List<Reminder>) {
        load(context).forEach { cancel(context, it.id) }
        save(context, reminders)
        reminders.forEach { schedule(context, it) }
    }

    /** Telefon qayta yoqilganda / ilova yangilanganda. */
    fun restore(context: Context) {
        val now = System.currentTimeMillis()
        val restored = load(context).mapNotNull { r ->
            when {
                r.at > now -> r
                now - r.at < MISSED_GRACE_MS -> r.copy(at = now + 10_000) // o'tkazib yuborilgan
                r.repeatYearly -> r.copy(at = rollForward(r.at, now))
                else -> null
            }
        }
        save(context, restored)
        restored.forEach { schedule(context, it) }
    }

    fun find(context: Context, id: Int): Reminder? = load(context).firstOrNull { it.id == id }

    /** Chalingandan keyin: har yilgi — kelasi yilga, bir martalik — o'chiriladi. */
    fun afterFired(context: Context, fired: Reminder) {
        val rest = load(context).filter { it.id != fired.id }
        if (fired.repeatYearly) {
            val next = fired.copy(at = rollForward(fired.at, System.currentTimeMillis()))
            save(context, rest + next)
            schedule(context, next)
        } else {
            save(context, rest)
        }
    }

    fun reminderId(intent: Intent): Int = intent.getIntExtra(EXTRA_ID, -1)

    private fun schedule(context: Context, r: Reminder) {
        val alarms = context.getSystemService(AlarmManager::class.java)
        val pending = pendingIntent(context, r.id, PendingIntent.FLAG_UPDATE_CURRENT) ?: return
        val exactAllowed = Build.VERSION.SDK_INT < 31 || alarms.canScheduleExactAlarms()
        if (exactAllowed) {
            alarms.setExactAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, r.at, pending)
        } else {
            alarms.setAndAllowWhileIdle(AlarmManager.RTC_WAKEUP, r.at, pending)
        }
    }

    private fun cancel(context: Context, id: Int) {
        val pending = pendingIntent(context, id, PendingIntent.FLAG_NO_CREATE) ?: return
        context.getSystemService(AlarmManager::class.java).cancel(pending)
        pending.cancel()
    }

    private fun pendingIntent(context: Context, id: Int, flag: Int): PendingIntent? {
        val intent = Intent(context, ReminderReceiver::class.java).putExtra(EXTRA_ID, id)
        return PendingIntent.getBroadcast(context, id, intent, flag or PendingIntent.FLAG_IMMUTABLE)
    }

    private fun rollForward(at: Long, now: Long): Long {
        val calendar = Calendar.getInstance().apply { timeInMillis = at }
        while (calendar.timeInMillis <= now) calendar.add(Calendar.YEAR, 1)
        return calendar.timeInMillis
    }

    private fun load(context: Context): List<Reminder> {
        val raw = context.getSharedPreferences(PREFS, Context.MODE_PRIVATE).getString(KEY, null)
            ?: return emptyList()
        return try {
            val array = JSONArray(raw)
            (0 until array.length()).map { Reminder.fromJson(array.getJSONObject(it)) }
        } catch (e: Exception) {
            emptyList()
        }
    }

    private fun save(context: Context, reminders: List<Reminder>) {
        val array = JSONArray().apply { reminders.forEach { put(it.toJson()) } }
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
            .edit().putString(KEY, array.toString()).apply()
    }
}
