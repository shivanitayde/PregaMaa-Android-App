import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    const settings = InitializationSettings(android: android);

    await _notifications.initialize(settings);
  }

  static Future scheduleNotification(
    int id,
    String title,
    DateTime dateTime, {
    bool repeatDaily = false, // 🔥 new parameter
  }) async {
    if (repeatDaily) {
      // 🔁 DAILY REPEAT
      await _notifications.zonedSchedule(
        id,
        "Daily Reminder",
        title,
        tz.TZDateTime.from(dateTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel id',
            'task channel',
            importance: Importance.max,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation
                .absoluteTime, // 🔥 repeat daily
      );
    } else {
      // 🔔 ONE TIME
      await _notifications.zonedSchedule(
        id,
        "Task Reminder",
        title,
        tz.TZDateTime.from(dateTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel id',
            'task channel',
            importance: Importance.max,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  static Future cancelNotification(int id) async {
    await _notifications.cancel(id);
  }
}
