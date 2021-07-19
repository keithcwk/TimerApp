import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer_app/playPause_button.dart';
import 'package:timer_app/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage>
    with SingleTickerProviderStateMixin {
  static const maxSeconds = 10;
  int seconds = maxSeconds;
  Timer timer;
  bool isPaused = false;
  AnimationController _controller;
  Animation _timerAnimation;

  // to start timer
  void startTimer({bool reset = true}) {
    // time == 0 and play is pressed
    if (reset) {
      _controller.reset();
      _controller.forward();
      resetTimer();
    }

    timer = Timer.periodic(Duration(seconds: 1), (_) {
      // decrement if seconds > 0
      if (seconds > 0) {
        setState(() => seconds--);
      }
      // time == 0, does not reset automatically
      else
        stopTimer(reset: false);
    });
  }

  // to pause or reset the timer
  void stopTimer({bool reset = true}) {
    // reset condition
    // toggled when stop is pressed
    if (reset) {
      resetTimer();
    }
    setState(() => timer.cancel());
  }

  // reset the timer to original value
  void resetTimer() {
    setState(() {
      seconds = maxSeconds;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(seconds: maxSeconds + 1), vsync: this);

    _timerAnimation = Tween(begin: 1.0, end: 0.0).animate(_controller);
    _controller.addListener(() {
      // print(_controller.value);
      print(_timerAnimation.value);
    });

    _controller.addStatusListener((status) {});
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
          children: [
            SizedBox(height: 10),
            timerClock(),
            SizedBox(height: 60),
            controlsButton()
          ],
        )));
  }

  // Building the 'start' button widget
  Widget controlsButton() {
    final isRunning = timer == null ? false : timer.isActive;
    // isCompleted when timer is not started, or timer runs out
    final isCompleted = seconds == maxSeconds || seconds == 0;

    // displaying button accordingly
    // !isCompleted used so stop is shown as long as timer has been started
    // if !isCompleted is not used, stop is only shown when played
    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PlayPauseButton(
                runState: isRunning,
                onClicked: () {
                  if (isRunning) {
                    _controller.stop();
                    print('Paused');
                    stopTimer(reset: false);
                  } else {
                    _controller.forward();
                    print('Resumed');
                    startTimer(reset: false);
                  }
                },
              ),
              stopButton()
            ],
          )
        : PlayPauseButton(
            runState: isRunning,
            onClicked: () {
              _controller.forward();
              startTimer();
            });
  }

  Widget timerClock() {
    return SizedBox(
      height: 200,
      width: 200,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(child: timeDisplay()),
          AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, _) {
                return CircularProgressIndicator(
                  value: _timerAnimation.value,
                  valueColor: AlwaysStoppedAnimation(themeBlueLight),
                  backgroundColor: themeBlackLight,
                  strokeWidth: 8,
                );
              }),
        ],
      ),
    );
  }

  // Numerical display of the timer
  Widget timeDisplay() {
    return Text('$seconds',
        style: GoogleFonts.montserrat(
            color: Colors.white, fontSize: 80, fontWeight: FontWeight.w500));
  }

  // stop button
  Widget stopButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            primary: themeBlackLight,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        child: Container(
            // color: Colors.white,
            height: 35,
            width: 35,
            child:
                Center(child: Icon(Icons.stop, color: Colors.white, size: 35))),
        onPressed: (() {
          _controller.reset();
          stopTimer();
        }));
  }
}
