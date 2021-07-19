import 'dart:async';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:timer_app/button_widget.dart';
import 'package:timer_app/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_app/shared/utils.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  static const maxSeconds = 5;
  int seconds = maxSeconds;
  bool isButtonClickable = true;
  Timer timer;
  int _alarmId = 1;

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
                      clickDelay();
                      stopTimer(reset: false);
                    } else {
                      clickDelay();
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
    if (seconds <= 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlinkText('Time\'s Up!',
                style:
                    GoogleFonts.montserrat(color: Colors.white, fontSize: 20),
                duration: Duration(milliseconds: 700)),
            BlinkText('${seconds.toStringAsFixed(0)}',
                style:
                    GoogleFonts.montserrat(color: Colors.white, fontSize: 70),
                duration: Duration(milliseconds: 700))
          ],
        ),
      );
    }
    return Text('${seconds.toStringAsFixed(0)}',
        style: GoogleFonts.montserrat(
            color: Colors.white, fontSize: 70, fontWeight: FontWeight.w500));
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
          )
        ],
      ),
    );
  }

// ----------------------------------------------------------------------------
  // Function to start timer
  void startTimer({bool reset = true}) {
    // If start is pressed when seconds = 0
    if (reset) {
      resetTimer();
    }

    timer = Timer.periodic(Duration(seconds: 1), (_) {
      // Decrement seconds after every second
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      }

      // Stops the timer but does not reset
      else {
        stopTimer(reset: false);
      }

      // Execute background timer
      AndroidAlarmManager.oneShot(
          Duration(seconds: seconds.toInt()), _alarmId, alarmCallback,
          exact: true, wakeup: true);
    });
  }

  // Stop timer function
  void stopTimer({bool reset = true}) {
    // If reset = true
    if (reset) {
      resetTimer();
    }

    // toggles notif if and only time is out
    if (seconds == 0) {
      Utils.scheduleAlarm();
    }

    setState(() {
      timer.cancel();
      AndroidAlarmManager.cancel(_alarmId);
    });
  }

  // Reset timer
  void resetTimer() {
    setState(() {
      seconds = maxSeconds;
    });
  }

  // callback function for alarm manager
  void alarmCallback() {
    debugPrint("Alarm started at ${DateTime.now()}");
  }

  // Prevent spam pause/resume inputs
  void clickDelay() async {
    Duration time = Duration(milliseconds: 10);
    setState(() {
      isButtonClickable = false;

      Future.delayed(time, () {
        setState(() {
          isButtonClickable = true;
        });
      });
    });
  }
}
