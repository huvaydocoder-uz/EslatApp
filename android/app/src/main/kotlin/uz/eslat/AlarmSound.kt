package uz.eslat

import android.content.Context
import android.content.Intent
import android.media.AudioAttributes
import android.media.MediaPlayer
import android.media.RingtoneManager
import android.net.Uri

/**
 * Foydalanuvchi telefon xotirasidan tanlagan budilnik musiqasi.
 * Fayl tizim oynasi (ACTION_OPEN_DOCUMENT) orqali tanlanadi — ilova faqat
 * shu bitta faylga doimiy ruxsat oladi, xotirani o'qish ruxsati kerak emas.
 */
object AlarmSound {
    private const val PREFS = "eslat_alarm"
    private const val KEY_URI = "uri"
    private const val KEY_NAME = "name"

    fun name(context: Context): String? = prefs(context).getString(KEY_NAME, null)

    private fun uri(context: Context): Uri? =
        prefs(context).getString(KEY_URI, null)?.let(Uri::parse)

    fun save(context: Context, uri: Uri, name: String) {
        context.contentResolver.takePersistableUriPermission(
            uri, Intent.FLAG_GRANT_READ_URI_PERMISSION,
        )
        reset(context)
        prefs(context).edit().putString(KEY_URI, uri.toString()).putString(KEY_NAME, name).apply()
    }

    fun reset(context: Context) {
        uri(context)?.let {
            try {
                context.contentResolver.releasePersistableUriPermission(
                    it, Intent.FLAG_GRANT_READ_URI_PERMISSION,
                )
            } catch (e: Exception) {
                // Ruxsat allaqachon yo'q — muhim emas.
            }
        }
        prefs(context).edit().clear().apply()
    }

    /** Tanlangan musiqa; ochilmasa (fayl o'chirilgan) — standart budilnik ovozi. */
    fun createPlayer(context: Context, looping: Boolean): MediaPlayer? {
        val candidates = listOfNotNull(
            uri(context),
            RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM),
            RingtoneManager.getDefaultUri(RingtoneManager.TYPE_RINGTONE),
            RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION),
        )
        val attributes = AudioAttributes.Builder()
            .setUsage(AudioAttributes.USAGE_ALARM)
            .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
            .build()
        for (candidate in candidates) {
            val player = MediaPlayer()
            try {
                player.setAudioAttributes(attributes)
                player.setDataSource(context, candidate)
                player.isLooping = looping
                player.prepare()
                return player
            } catch (e: Exception) {
                player.release()
            }
        }
        return null
    }

    private fun prefs(context: Context) =
        context.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
}
