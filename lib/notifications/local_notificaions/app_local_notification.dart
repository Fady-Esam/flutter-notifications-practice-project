import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();
  static onDidReceiveBackgroundNotificationResponse(
    NotificationResponse notificationResponse,
  ) {}
  // static onDidReceiveNotificationResponse(
  // NotificationResponse notificationResponse) {}
  static Future<void> initialize() async {
    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await notifications.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
      onDidReceiveNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );
  }

  static Future<void> showNotification() async {
    NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        'id 1',
        'channel_name56',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    await notifications.show(
      0,
      'Simple Notification',
      'So Good',
      notificationDetails,
    );
  }

  static Future<void> cancelNotification({required int id}) async {
    await notifications.cancel(id);
  }

  static Future<void> showRepeatedNotification() async {
    NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(
        'id 2',
        'channel_name49',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    await notifications.periodicallyShow(
      0,
      'Repeatd Notification',
      'So Good',
      RepeatInterval.weekly,
      notificationDetails,
    );
  }

  static Future<void> showShceduledNotification() async {
    NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails(
      'id 2',
      'channel_name49',
      importance: Importance.max,
      priority: Priority.high,
    ));
    var currentTimeZone = await FlutterTimezone.getLocalTimezone();
    await notifications.zonedSchedule(
      7,
      'Scheduled Notification',
      'So Good',
      tz.TZDateTime.now(tz.getLocation(currentTimeZone))
          .add(const Duration(seconds: 5)),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
