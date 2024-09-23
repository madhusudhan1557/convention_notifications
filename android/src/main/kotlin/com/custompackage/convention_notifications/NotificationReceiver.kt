package com.custompackage.convention_notifications

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import io.flutter.plugin.common.MethodChannel

class NotificationReceiver(private val methodChannel: MethodChannel) : BroadcastReceiver() {

    override fun onReceive(context: Context?, intent: Intent?) {
        val payload = intent?.getStringExtra("payload")
         println(payload)
        payload?.let {
            methodChannel.invokeMethod("onNotificationTap", it)
        }
    }
}
