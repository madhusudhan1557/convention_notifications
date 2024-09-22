import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'convention_notifications_method_channel.dart';

abstract class ConventionNotificationsPlatform extends PlatformInterface {
  /// Constructs a ConventionNotificationsPlatform.
  ConventionNotificationsPlatform() : super(token: _token);

  static final Object _token = Object();

  static ConventionNotificationsPlatform _instance = MethodChannelConventionNotifications();

  /// The default instance of [ConventionNotificationsPlatform] to use.
  ///
  /// Defaults to [MethodChannelConventionNotifications].
  static ConventionNotificationsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ConventionNotificationsPlatform] when
  /// they register themselves.
  static set instance(ConventionNotificationsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
