import 'convention_notifications_platform_interface.dart';

class ConventionNotifications {

  Future<String?> getPlatformVersion() {
    return ConventionNotificationsPlatform.instance.getPlatformVersion();
  }

  Future<void> showNotification(
      { required String title, required String description, String? payload , String? icon}) async {
    return await ConventionNotificationsPlatform.instance
        .showNotification(title : title, description : description, payload: payload, icon: icon);
  }

  void setNotificationTapHandler(Function(String) onTap) {
    ConventionNotificationsPlatform.instance.setNotificationTapHandler(onTap);
  }
}
