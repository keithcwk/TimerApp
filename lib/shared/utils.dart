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

    await flutterLocalNotificationsPlugin.show(
        0, 'Time\'s Up!', 'Your timer has run out!', platformChannelSpecifics);
  }

  static List<String> stringFormatter(String time) {
    List<String> timeTemp = time.split("");
    var length = timeTemp.length;

    List<String> formatted = [];

    var hour = "";
    var minute = "";
    var seconds = "";

    if (length >= 5) {
      if (length >= 6 && timeTemp[0] != 0) {
        seconds = timeTemp[4] + timeTemp[5];
        minute = timeTemp[2] + timeTemp[3];
        hour += timeTemp[0] + timeTemp[1];
      } else if (length == 5) {
        seconds = timeTemp[3] + timeTemp[4];
        minute = timeTemp[1] + timeTemp[2];
        hour += "0" + timeTemp[0];
      }
    } else if (length >= 3) {
      if (length == 4) {
        seconds = timeTemp[2] + timeTemp[3];
        minute = timeTemp[0] + timeTemp[1];
        hour += "00";
      } else {
        seconds = timeTemp[1] + timeTemp[2];
        minute = "0" + timeTemp[0];
        hour += "00";
      }
    } else if (length >= 1) {
      if (length == 2) {
        seconds = timeTemp[0] + timeTemp[1];
        minute += "00";
        hour += "00";
      } else {
        seconds = "0" + timeTemp[0];
        minute = "00";
        hour += "00";
      }
    }

    formatted.add(hour);
    formatted.add(minute);
    formatted.add(seconds);
    return formatted;
  }
}
