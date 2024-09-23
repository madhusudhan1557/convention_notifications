import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:convention_notifications/convention_notifications_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelConventionNotifications platform =
      MethodChannelConventionNotifications();
  const MethodChannel channel = MethodChannel('convention_notifications');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });

  test('showNotification', () async {
    platform.showNotification( title : "Test", description:  "Test");
  });
}
