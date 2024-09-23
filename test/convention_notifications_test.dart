import 'package:flutter_test/flutter_test.dart';
import 'package:convention_notifications/convention_notifications.dart';
import 'package:convention_notifications/convention_notifications_platform_interface.dart';
import 'package:convention_notifications/convention_notifications_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockConventionNotificationsPlatform
    with MockPlatformInterfaceMixin
    implements ConventionNotificationsPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> setNotificationTapHandler(Function(String p1) onTap) {
    throw UnimplementedError();
  }

  @override
  Future<void> showNotification(
      {required String title, required String description, String? payload}) {
    throw UnimplementedError();
  }
}

void main() {
  final ConventionNotificationsPlatform initialPlatform =
      ConventionNotificationsPlatform.instance;

  test('$MethodChannelConventionNotifications is the default instance', () {
    expect(
        initialPlatform, isInstanceOf<MethodChannelConventionNotifications>());
  });

  test('getPlatformVersion', () async {
    ConventionNotifications conventionNotificationsPlugin =
        ConventionNotifications();
    MockConventionNotificationsPlatform fakePlatform =
        MockConventionNotificationsPlatform();
    ConventionNotificationsPlatform.instance = fakePlatform;

    expect(await conventionNotificationsPlugin.getPlatformVersion(), '42');
  });

  test('showNotification', () async {
    ConventionNotifications conventionNotificationsPlugin =
        ConventionNotifications();
    MockConventionNotificationsPlatform fakePlatform =
        MockConventionNotificationsPlatform();
    ConventionNotificationsPlatform.instance = fakePlatform;

    await conventionNotificationsPlugin.showNotification(
        title: "Test", description: "Description Test");
  });
}
