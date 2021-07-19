import 'package:flutter/material.dart';
import 'package:timer_app/TimerPage.dart';
import 'package:timer_app/Home.dart';
import 'package:timer_app/TimerAnimated.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TimerAnimated(),
      debugShowCheckedModeBanner: false,
    );
  }
}
