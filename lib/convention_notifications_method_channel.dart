import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'convention_notifications_platform_interface.dart';

/// An implementation of [ConventionNotificationsPlatform] that uses method channels.
class MethodChannelConventionNotifications extends ConventionNotificationsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('convention_notifications');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
