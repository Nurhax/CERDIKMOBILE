import 'dart:async';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

class NotiService {
  static final NotiService _instance = NotiService._internal();
  factory NotiService() => _instance;
  NotiService._internal();

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      final bool? granted = await notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      return granted ?? false;
    }
    return false;
  }

  Future<void> initNotification() async {
    if (_isInitialized) return;
    final permGranted = await requestPermissions();

    print('Initializing notifications...');
    print('Notification permission granted: $permGranted');

    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    print('Device timezone: $currentTimeZone');
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    const AndroidInitializationSettings initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSetting =
        InitializationSettings(android: initSettingsAndroid);

    await _createNotificationChannel();

    await notificationsPlugin.initialize(
      initSetting,
      onDidReceiveNotificationResponse: (details) {},
    );

    _isInitialized = true;
  }

  Future<void> _createNotificationChannel() async {
    print('Creating notification channel...');
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'daily_channel_id',
      'Daily Notification',
      description: 'Daily Notification Channel',
      importance: Importance.max,
      playSound: true, // Add this
      enableVibration: true, // Add this
    );
    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notification',
        channelDescription: 'Daily Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
      ),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    try {
      await notificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails(),
      );
    } catch (e) {
      print('Error showing notification: $e');
    }
  }

  Future<void> scheduleNotification({
    int id = 1,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    try {
      final now = tz.TZDateTime.now(tz.local);
      print('\nCurrent local time: $now');

      var scheduledDate =
          tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
      print('Initial scheduled time: $scheduledDate');

      // If the scheduled time is in the past, adjust it to the next day
      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      print('Final scheduled time: $scheduledDate');
      final timeUntilNotification = scheduledDate.difference(now);
      print('Time until notification: $timeUntilNotification');

      // Schedule the notification without the timer
      await notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        scheduledDate,
        notificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exact, // Use exact mode
        matchDateTimeComponents: DateTimeComponents.time,
      );

      print('Notification scheduled successfully\n');
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }
}
