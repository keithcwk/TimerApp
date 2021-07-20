import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer_app/home.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  // Notification Initialization
  WidgetsFlutterBinding.ensureInitialized();
  var initializationSettingsAndroid =
      AndroidInitializationSettings('outline_timer_black_24dp');

  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSetttings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSetttings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('Notification Payload: ' + payload);
    }
  });
  runApp(MyApp());

  // Alarm Manager Initialization
  await AndroidAlarmManager.initialize();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
