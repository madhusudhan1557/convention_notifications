
import 'convention_notifications_platform_interface.dart';

class ConventionNotifications {

  Future<String?> getPlatformVersion() {
    return ConventionNotificationsPlatform.instance.getPlatformVersion();
  }

  static Future<void> showNotification(String title, String description, String payload) async {
    return await  ConventionNotificationsPlatform.instance.showNotification(title, description, payload);
  }

  static void setNotificationTapHandler(Function(String) onTap) {
     ConventionNotificationsPlatform.instance.setNotificationTapHandler(onTap);
  }

}
