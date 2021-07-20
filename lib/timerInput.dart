import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:timer_app/timerPage.dart';
import 'package:timer_app/shared/button_widget.dart';
import 'package:timer_app/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_app/shared/keyboardNumbers.dart';
import 'package:timer_app/shared/utils.dart';

class TimerInput extends StatefulWidget {
  @override
  _TimerInputState createState() => _TimerInputState();
}

class _TimerInputState extends State<TimerInput>
    with SingleTickerProviderStateMixin {
  String display;
  List<String> timeFormatted = ["00", "00", "00"];
  FToast fToast;

  void initState() {
    super.initState();
    display = "";
    fToast = FToast();
    fToast.init(context);
  }

  void dispose() {
    super.dispose();
    display = "";
  }

  void _onKeyboardTap(String value) {
    setState(() {
      if (display.split("").length < 6) {
        display = display + value;
        print(display);
        timeFormatted = Utils.stringFormatter(display);
        print(timeFormatted);
      }
    });
  }

  void _leftButton() {
    if (display != "") {
      setState(() {
        var tempList = display.split("");
        tempList.removeLast();
        display = tempList.join("");
        timeFormatted = Utils.stringFormatter(display);
      });
    }
    print(display);
    print(timeFormatted);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        // Enter timer value
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(display != "" ? '${timeFormatted[0]}' : "00",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: 60,
                    fontWeight: FontWeight.w400,
                    color: themeGrey)),
            Text('h',
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: themeGrey)),
            SizedBox(width: 20),
            Text(display != "" ? '${timeFormatted[1]}' : "00",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: 60,
                    fontWeight: FontWeight.w400,
                    color: themeGrey)),
            Text('m',
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: themeGrey)),
            SizedBox(width: 20),
            Text(display != "" ? '${timeFormatted[2]}' : "00",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: 60,
                    fontWeight: FontWeight.w400,
                    color: themeGrey)),
            Text('s',
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: themeGrey)),
          ],
        ),
        SizedBox(height: 30),
        // Divider line
        Divider(
            height: 10,
            thickness: 0.75,
            color: Colors.white.withOpacity(0.3),
            indent: 30,
            endIndent: 30),
        // Keyboard numbers
        KeyboardNumbers(
          onKeyboardTap: _onKeyboardTap,
          textColor: themeGrey,
          leftIcon: Icon(Icons.backspace, color: themeGrey),
          leftButtonFn: _leftButton,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        ),
        // Start button
        AnimatedOpacity(
            opacity: display != "" ? 1.0 : 0.0,
            duration: Duration(milliseconds: 300),
            child: ButtonWidget(
                text: 'Start',
                onClicked: () {
                  print('Total seconds: ${Utils.convertToSec(timeFormatted)}');
                  if (Utils.convertToSec(timeFormatted) > 0) {
                    // Utils.addTimerPages(
                    //     TimerPage(timeFormatted: timeFormatted));
                    // Get.to(() => Home());
                    Get.to(() => TimerPage(timeFormatted: timeFormatted));
                  } else {
                    Utils.showToast("Please include a valid time", fToast);
                  }
                },
                labelColor: Colors.white,
                buttonColor: themeBlackLight))
      ],
    );
  }
}
