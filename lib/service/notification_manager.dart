import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future initialize() async {
    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});
    const androidInitialize =
        AndroidInitializationSettings('mipmap/ic_launcher');
    final initializationsSettings = InitializationSettings(
        android: androidInitialize, iOS: initializationSettingsIOS);
    if (Platform.isAndroid) {
      _notifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestNotificationsPermission();
    }

    if (Platform.isIOS) {
      _notifications
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()!
          .checkPermissions();
    }

    await _notifications.initialize(initializationsSettings);
  }

  static Future _notificationDetails() async => const NotificationDetails(
        iOS: DarwinNotificationDetails(),
        android: AndroidNotificationDetails(
          "DoDo",
          "day_counterr_1",
          importance: Importance.max,
        ),
      );

  static Future showNotification({
    int id = 0,
    required String title,
    required String body,
    required String payload, // bildirime extra veri eklemek istersek
  }) async =>
      _notifications.show(id, title, body, await _notificationDetails(),
          payload: payload);

  static Future scheduleNotification({
    required int id,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDateTime,
  }) async {
    if (scheduledDateTime.isAfter(DateTime.now())) {
      return _notifications.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheduledDateTime, tz.local),
          await _notificationDetails(),
          androidScheduleMode: AndroidScheduleMode.alarmClock,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
    }
  }

  static Future unScheduleNotification(int notificationId) async =>
      await _notifications.cancel(notificationId);
}
