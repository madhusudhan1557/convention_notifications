package com.custompackage.convention_notifications

import android.Manifest
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class NotificationManagerKt(private val context: Context, private val methodChannel: MethodChannel) {

    private val CHANNEL_ID = "convention_notifications_channel"
    private val notificationId = 1001

    init {
        createNotificationChannel()
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val name = context.getString(R.string.channel_name)
            val descriptionText = context.getString(R.string.channel_description)
            val importance = NotificationManager.IMPORTANCE_DEFAULT
            val channel = NotificationChannel(CHANNEL_ID, name, importance).apply {
                description = descriptionText
            }

            val notificationManager: NotificationManager =
                context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }

    fun showNotification(call: MethodCall, result: MethodChannel.Result) {
        val title = call.argument<String>("title") ?: "Default Title"
        val description = call.argument<String>("description") ?: "Default Description"
        val payload = call.argument<String>("payload") ?: "" 
        val iconName = call.argument<String>("icon") ?: "ic_launcher" // Default icon name

        // Try to get the resource ID from mipmap first
        var iconResourceId = context.resources.getIdentifier(iconName, "mipmap", context.packageName)

        // If not found, try drawable
        if (iconResourceId == 0) {
            iconResourceId = context.resources.getIdentifier(iconName, "drawable", context.packageName)
        }

        // Fallback to default icon if still not found
        if (iconResourceId == 0) {
            iconResourceId = android.R.drawable.ic_dialog_info
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            if (ActivityCompat.checkSelfPermission(context, Manifest.permission.POST_NOTIFICATIONS) != PackageManager.PERMISSION_GRANTED) {
                result.error("PERMISSION_DENIED", "Notification permission not granted", null)
                return
            }
        }

        // Create an intent with the payload
        val intent = Intent(context, NotificationReceiver::class.java).apply {
            putExtra("payload", payload)  // Add the payload to the intent
            println(payload)
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        }

        val pendingIntent: PendingIntent = PendingIntent.getBroadcast(
            context, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val builder = NotificationCompat.Builder(context, CHANNEL_ID)
            .setSmallIcon(iconResourceId)
            .setContentTitle(title)
            .setContentText(description)
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)
            .setContentIntent(pendingIntent)
            .setAutoCancel(true)

        with(NotificationManagerCompat.from(context)) {
            notify(notificationId, builder.build())
        }

        result.success("Notification Shown")
    }
}
