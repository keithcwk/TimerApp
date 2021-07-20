import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_app/shared/constants.dart';
import 'package:timer_app/timerInput.dart';

class Home extends StatefulWidget {
  // static List<Widget> timerPages = [];
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themeBlack,
        appBar: AppBar(
          title: Text('Timer',
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
          backgroundColor: themeBlack,
          elevation: 0.0,
          centerTitle: true,
        ),
        // body: Home.timerPages.length == 0 ? TimerInput() : Home.timerPages[0]);
        body: TimerInput());
  }
}
