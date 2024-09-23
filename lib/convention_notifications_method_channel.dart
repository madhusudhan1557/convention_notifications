import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'convention_notifications_platform_interface.dart';

/// An implementation of [ConventionNotificationsPlatform] that uses method channels.
class MethodChannelConventionNotifications
    extends ConventionNotificationsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('convention_notifications');
  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> showNotification(
      { required String title, required String description, String? payload, String? icon}) async {
       try {
      await methodChannel.invokeMethod('showNotification', {
        'title': title,
        'description': description,
        'payload': payload,
      });
    } on PlatformException catch (e) {
      throw Exception("Error showing notification: ${e.message}");
    }
  }

  @override
  void setNotificationTapHandler(Function(String) onTap)  {
     methodChannel.setMethodCallHandler((call) async {
      if (call.method == 'onNotificationTap') {
        String payload = call.arguments as String;
        onTap(payload); 
      }
    });
  }
}
