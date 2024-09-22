package com.custompackage.convention_notifications

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import io.flutter.plugin.common.MethodChannel

class NotificationReceiver(private val methodChannel: MethodChannel) : BroadcastReceiver() {

    override fun onReceive(context: Context?, intent: Intent?) {
        // Get the payload from the intent
        val payload = intent?.getStringExtra("payload")

        // Send the payload back to Flutter using the MethodChannel
        payload?.let {
            methodChannel.invokeMethod("onNotificationTap", it)
        }
    }
}
