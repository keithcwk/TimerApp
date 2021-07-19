import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer_app/button_widget.dart';
import 'package:timer_app/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  static const maxSeconds = 10;
  int seconds = maxSeconds;
  Timer timer;

  void startTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    // change to seconds : 1
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        stopTimer(reset: false);
      }
    });
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    setState(() {
      timer.cancel();
    });
  }

  void resetTimer() {
    setState(() {
      seconds = maxSeconds;
    });
  }

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
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [timerClock(), SizedBox(height: 60), buildButtons()],
        )));
  }

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer.isActive;
    final isCompleted = seconds == maxSeconds || seconds == 0;

    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                  text: isRunning ? 'Pause' : 'Resume',
                  onClicked: () {
                    if (isRunning) {
                      stopTimer(reset: false);
                    } else {
                      startTimer(reset: false);
                    }
                  },
                  buttonColor: themeBlackLight,
                  labelColor: Colors.white),
              SizedBox(width: 20),
              ButtonWidget(
                  text: 'Reset',
                  onClicked: stopTimer,
                  buttonColor: themeBlackLight,
                  labelColor: Colors.white),
            ],
          )
        : ButtonWidget(
            text: 'Start',
            onClicked: () {
              startTimer();
            },
            buttonColor: themeBlackLight,
            labelColor: Colors.white);
  }

  Widget buildTime() {
    if (seconds == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Time\'s Up!',
                style:
                    GoogleFonts.montserrat(color: Colors.white, fontSize: 20)),
            Text('$seconds',
                style:
                    GoogleFonts.montserrat(color: Colors.white, fontSize: 70))
          ],
        ),
      );
    }
    return Text('$seconds',
        style: GoogleFonts.montserrat(
            color: Colors.white, fontSize: 80, fontWeight: FontWeight.w500));
  }

  Widget timerClock() {
    return SizedBox(
      height: 200,
      width: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(child: buildTime()),
          CircularProgressIndicator(
            value: seconds / maxSeconds,
            valueColor: AlwaysStoppedAnimation(themeBlueLight),
            backgroundColor: themeBlackLight,
            strokeWidth: 8,
          ),
        ],
      ),
    );
  }
}
