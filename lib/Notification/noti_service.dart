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

    await _createNotificationChannel(
      channelId: 'default_channel',
      channelName: 'Default Channel',
      soundName: null,
    );

    await notificationsPlugin.initialize(
      initSetting,
      onDidReceiveNotificationResponse: (details) {},
    );

    _isInitialized = true;
  }

  Future<void> _createNotificationChannel({
    required String channelId,
    required String channelName,
    required String? soundName,
  }) async {
    final androidChannel = AndroidNotificationChannel(
      channelId,
      channelName,
      description: 'Channel with custom sound',
      importance: Importance.max,
      sound: soundName != null
          ? RawResourceAndroidNotificationSound(soundName.toLowerCase())
          : null,
      playSound: true,
      enableVibration: true,
    );

    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }

  NotificationDetails notificationDetails({
    required String channelId,
    required String channelName,
    String? soundName,
  }) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: 'Channel with custom sound',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        showWhen: true,
        sound: soundName != null
            ? RawResourceAndroidNotificationSound(soundName.toLowerCase())
            : null,
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
        notificationDetails(
          channelId: 'default_channel',
          channelName: 'Default Channel',
          soundName: null,
        ),
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
    String? soundName,
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

      final channelId = soundName != null
          ? 'channel_${soundName.toLowerCase()}'
          : 'default_channel';
      final channelName =
          soundName != null ? 'Channel for $soundName' : 'Default Channel';

      await _createNotificationChannel(
        channelId: channelId,
        channelName: channelName,
        soundName: soundName,
      );

      await notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        scheduledDate,
        notificationDetails(
          channelId: channelId,
          channelName: channelName,
          soundName: soundName,
        ),
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
