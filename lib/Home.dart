import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer_app/button_widget.dart';
// import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:timer_app/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_app/shared/keyboardNumbers.dart';
import 'package:timer_app/shared/utils.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  String display = "";
  List<String> timeFormatted = ["00", "00", "00"];

  void initState() {
    super.initState();
    display = "";
    List<String> timeFormatted = ["00", "00", "00"];
  }

  void dispose() {
    super.dispose();
    display = "";
    List<String> timeFormatted = ["00", "00", "00"];
  }

  void _onKeyboardTap(String value) {
    setState(() {
      display = display + value;
      print(display);
      timeFormatted = Utils.stringFormatter(display);
      print(timeFormatted);
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
      body: Column(
        children: [
          SizedBox(height: 30),
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
          Divider(
              height: 10,
              thickness: 0.75,
              color: Colors.white.withOpacity(0.3),
              indent: 30,
              endIndent: 30),
          KeyboardNumbers(
            onKeyboardTap: _onKeyboardTap,
            textColor: themeGrey,
            leftIcon: Icon(Icons.backspace, color: themeGrey),
            leftButtonFn: _leftButton,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          AnimatedOpacity(
              opacity: display != "" ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: ButtonWidget(
                  text: 'Start',
                  onClicked: () {},
                  labelColor: Colors.white,
                  buttonColor: themeBlackLight))
          // Container(
          //     height: 50,
          //     child: display != ""
          //         ? ButtonWidget(
          //             text: 'Start',
          //             onClicked: () {},
          //             labelColor: Colors.white,
          //             buttonColor: themeBlackLight)
          //         : SizedBox(width: 10, height: 10))
        ],
      ),
    );
  }
}
