import 'package:flutter/services.dart';

import 'convention_notifications_platform_interface.dart';

class ConventionNotifications {
  static const MethodChannel _channel =
      MethodChannel('convention_notifications');
  Future<String?> getPlatformVersion() {
    return ConventionNotificationsPlatform.instance.getPlatformVersion();
  }

  static Future<void> showNotification(String title, String description, String payload) async {
    try {
      await _channel.invokeMethod('showNotification', {
        'title': title,
        'description': description,
        'payload': payload,
      });
    } on PlatformException catch (e) {
      throw Exception("Error showing notification: ${e.message}");
    }
  }

  static void setNotificationTapHandler(Function(String) onTap) {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onNotificationTap') {
        String payload = call.arguments as String;
        onTap(payload); 
      }
    });
  }

}
