package uz.eslat

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.pm.ServiceInfo
import android.media.MediaPlayer
import android.net.Uri
import android.os.Build
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.os.VibrationEffect
import android.os.Vibrator
import android.os.VibratorManager

/**
 * Budilnik: tanlangan musiqa to'xtatilmaguncha takrorlanadi, telefon tebranadi,
 * qulflangan ekranda ham budilnik sahifasi ochiladi. Batareyani asrash uchun
 * 30 daqiqadan keyin o'zi to'xtaydi.
 */
class AlarmService : Service() {
    private var player: MediaPlayer? = null
    private var vibrator: Vibrator? = null
    private val handler = Handler(Looper.getMainLooper())

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if (intent?.action == ACTION_STOP) {
            stopAlarm()
            return START_NOT_STICKY
        }
        val title = intent?.getStringExtra(EXTRA_TITLE) ?: getString(R.string.alarm_channel)
        val body = intent?.getStringExtra(EXTRA_BODY).orEmpty()
        val route = intent?.getStringExtra(EXTRA_ROUTE)
        val notification = buildNotification(title, body, route)
        if (Build.VERSION.SDK_INT >= 29) {
            startForeground(NOTIFICATION_ID, notification, ServiceInfo.FOREGROUND_SERVICE_TYPE_MEDIA_PLAYBACK)
        } else {
            startForeground(NOTIFICATION_ID, notification)
        }
        startSound()
        handler.removeCallbacksAndMessages(null)
        handler.postDelayed({ stopAlarm() }, MAX_RING_MS)
        return START_NOT_STICKY
    }

    private fun startSound() {
        player?.release()
        player = AlarmSound.createPlayer(this, looping = true)?.also { it.start() }
        vibrator = if (Build.VERSION.SDK_INT >= 31) {
            getSystemService(VibratorManager::class.java).defaultVibrator
        } else {
            @Suppress("DEPRECATION")
            getSystemService(Vibrator::class.java)
        }
        val pattern = longArrayOf(0, 800, 700)
        if (Build.VERSION.SDK_INT >= 26) {
            vibrator?.vibrate(VibrationEffect.createWaveform(pattern, 0))
        } else {
            @Suppress("DEPRECATION")
            vibrator?.vibrate(pattern, 0)
        }
    }

    private fun stopAlarm() {
        handler.removeCallbacksAndMessages(null)
        player?.run {
            try {
                stop()
            } catch (e: Exception) {
                // Allaqachon to'xtagan.
            }
            release()
        }
        player = null
        vibrator?.cancel()
        vibrator = null
        if (Build.VERSION.SDK_INT >= 24) {
            stopForeground(STOP_FOREGROUND_REMOVE)
        } else {
            @Suppress("DEPRECATION")
            stopForeground(true)
        }
        stopSelf()
    }

    override fun onDestroy() {
        handler.removeCallbacksAndMessages(null)
        player?.release()
        vibrator?.cancel()
        super.onDestroy()
    }

    private fun buildNotification(title: String, body: String, route: String?): Notification {
        val manager = getSystemService(NotificationManager::class.java)
        val builder = if (Build.VERSION.SDK_INT >= 26) {
            manager.createNotificationChannel(
                NotificationChannel(
                    CHANNEL_ID, getString(R.string.alarm_channel), NotificationManager.IMPORTANCE_HIGH,
                ).apply {
                    setSound(null, null) // musiqani o'zimiz chalamiz
                    enableVibration(false)
                },
            )
            Notification.Builder(this, CHANNEL_ID)
        } else {
            @Suppress("DEPRECATION")
            Notification.Builder(this).setPriority(Notification.PRIORITY_MAX)
        }
        val open = Intent(this, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
            if (route != null) data = Uri.parse("eslat://app$route")
        }
        val openPending = PendingIntent.getActivity(
            this, NOTIFICATION_ID, open,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
        val stopPending = PendingIntent.getService(
            this, NOTIFICATION_ID, Intent(this, AlarmService::class.java).setAction(ACTION_STOP),
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
        val stopAction = Notification.Action.Builder(
            null, getString(R.string.alarm_stop), stopPending,
        ).build()
        return builder
            .setSmallIcon(R.drawable.ic_notification)
            .setContentTitle(title)
            .setContentText(body)
            .setCategory(Notification.CATEGORY_ALARM)
            .setOngoing(true)
            .setContentIntent(openPending)
            .setFullScreenIntent(openPending, true)
            .addAction(stopAction)
            .build()
    }

    companion object {
        private const val CHANNEL_ID = "eslat_alarm"
        private const val NOTIFICATION_ID = 0x3e5a
        private const val MAX_RING_MS = 30 * 60 * 1000L
        private const val ACTION_STOP = "uz.eslat.alarm.STOP"
        private const val EXTRA_TITLE = "title"
        private const val EXTRA_BODY = "body"
        private const val EXTRA_ROUTE = "route"

        fun start(context: Context, title: String, body: String, route: String) {
            val intent = Intent(context, AlarmService::class.java)
                .putExtra(EXTRA_TITLE, title)
                .putExtra(EXTRA_BODY, body)
                .putExtra(EXTRA_ROUTE, route)
            if (Build.VERSION.SDK_INT >= 26) {
                context.startForegroundService(intent)
            } else {
                context.startService(intent)
            }
        }

        fun stop(context: Context) {
            context.startService(Intent(context, AlarmService::class.java).setAction(ACTION_STOP))
        }
    }
}
