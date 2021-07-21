import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as localNoti;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../main.dart';

class Utils {
  // Schedules a notification when the timer runs out
  static void scheduleAlarm() async {
    var androidPlatformChannelSpecifics = localNoti.AndroidNotificationDetails(
        'alarm_notif', 'alarm_notif', 'Channel for Alarm notification',
        icon: 'outline_timer_black_24dp',
        playSound: true,
        priority: localNoti.Priority.high,
        importance: localNoti.Importance.max,
        sound: RawResourceAndroidNotificationSound('bleepreduced'),
        additionalFlags: Int32List.fromList(<int>[4]));

    var iOSPlatformChannelSpecifics = localNoti.IOSNotificationDetails(
        sound: 'bleep.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);

    var platformChannelSpecifics = localNoti.NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0,
        'Time\'s Up!',
        'Your timer has run out! Click to stop timer!',
        platformChannelSpecifics);
  }

  // Formats a string of time into [HH:MM:SS]
  // Used in TimerInput
  static List<String> stringFormatter(String time) {
    List<String> timeTemp = time.split("");
    var length = timeTemp.length;

    List<String> formatted = [];

    var hour = "";
    var minute = "";
    var seconds = "";

    // HH:MM:SS
    if (length >= 5) {
      // Prevents overflow and empty input
      if (length >= 6 && timeTemp[0] != "00") {
        seconds = timeTemp[4] + timeTemp[5];
        minute = timeTemp[2] + timeTemp[3];
        hour += timeTemp[0] + timeTemp[1];
      } else if (length == 5) {
        seconds = timeTemp[3] + timeTemp[4];
        minute = timeTemp[1] + timeTemp[2];
        hour += "0" + timeTemp[0];
      }
    }

    // 00:MM:SS
    else if (length >= 3) {
      if (length == 4) {
        seconds = timeTemp[2] + timeTemp[3];
        minute = timeTemp[0] + timeTemp[1];
        hour += "00";
      } else {
        seconds = timeTemp[1] + timeTemp[2];
        minute = "0" + timeTemp[0];
        hour += "00";
      }
    }

    // 00:00:SS
    else if (length >= 1) {
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

    formatted.addAll([hour, minute, seconds]);
    return formatted;
  }

  // Convert list of ["HH", "MM", "SS"] into seconds
  // Used in TimerInput to check whether time > 0
  // Used in TimerPage
  static int convertToSec(List<String> formattedTime) {
    int totalTime = 0;

    totalTime = int.parse(formattedTime[2]) +
        int.parse(formattedTime[1]) * 60 +
        int.parse(formattedTime[0]) * 3600;
    return totalTime;
  }

  // Convert seconds into HH:MM:SS format
  // Used to display time in TimerPage
  static List<String> convertToHMS(int seconds) {
    List<String> display = [];
    String hour;
    String mins;
    String secs;

    hour = (seconds / 3600).truncate().toString();
    mins = (seconds.remainder(3600) / 60).truncate().toString();
    secs = (seconds.remainder(3600).remainder(60)).truncate().toString();
    display.addAll([hour, mins, secs]);
    print(display);
    return display;
  }

  // Displays the toast message
  static void showToast(String message, FToast fToast) {
    Widget toast = Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.grey.shade200,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
}
