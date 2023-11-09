// notification_manager.dart

import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationManager {
  static const String _lastNotificationIdKey = 'last_notification_id';

  static Future<int> getLastNotificationId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_lastNotificationIdKey) ?? 0;
  }

  static Future<void> setLastNotificationId(int notificationId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastNotificationIdKey, notificationId);
  }

  static Future<void> checkAndTriggerNotification(int latestNotificationId) async {
    int lastNotificationId = await getLastNotificationId();

    if (latestNotificationId > lastNotificationId) {
      // Trigger the notification here (implement your notification logic)
      // Update lastNotificationId to the latest value
      await setLastNotificationId(latestNotificationId);

      // Update the badge number
      FlutterAppBadger.updateBadgeCount(latestNotificationId);
    }
  }
}