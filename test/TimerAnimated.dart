import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer_app/shared/button_widget.dart';
import 'package:timer_app/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class TimerAnimated extends StatefulWidget {
  @override
  _TimerAnimatedState createState() => _TimerAnimatedState();
}

class _TimerAnimatedState extends State<TimerAnimated>
    with SingleTickerProviderStateMixin {
  static const maxSeconds = 20.0;
  double seconds = maxSeconds;
  bool isButtonClickable = true;
  Timer timer;
  Animation _timerAnimation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(seconds: (maxSeconds - 1).toInt()), vsync: this);
    _timerAnimation = Tween(begin: 1.0, end: 0.0).animate(_controller);
    _controller.addListener(() {
      setState(() => seconds = _timerAnimation.value * maxSeconds);
    });
    print(_timerAnimation.value);
  }

  void startTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    // change to seconds : 1
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      // Allows timer to run less than 0
      setState(() {
        seconds--;
        _controller.forward();
      });
    });
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    setState(() {
      timer.cancel();
      _controller.stop();
    });
  }

  void resetTimer() {
    setState(() {
      seconds = maxSeconds;
      _controller.reset();
    });
  }

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
            Text('Time\'s Up!',
                style:
                    GoogleFonts.montserrat(color: Colors.white, fontSize: 20)),
            Text('${seconds.toStringAsFixed(0)}',
                style:
                    GoogleFonts.montserrat(color: Colors.white, fontSize: 70))
          ],
        ),
      );
    }
    return Text('${seconds.toStringAsFixed(1)}',
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
}
