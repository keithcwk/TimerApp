import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as localNoti;
import '../main.dart';

class Utils {
  static void scheduleAlarm() async {
    var androidPlatformChannelSpecifics = localNoti.AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'outline_timer_black_24dp',
      largeIcon:
          localNoti.DrawableResourceAndroidBitmap('outline_timer_black_24dp'),
      playSound: true,
      priority: localNoti.Priority.high,
      importance: localNoti.Importance.max,
      timeoutAfter: 5000,
    );

    var iOSPlatformChannelSpecifics = localNoti.IOSNotificationDetails(
        sound: 'bleep.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);

    var platformChannelSpecifics = localNoti.NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(0, 'Office',
        'Good morning! Time for office.', platformChannelSpecifics);
  }
}
