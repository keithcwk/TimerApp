import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_app/shared/constants.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onClicked;
  final String text;
  final Color labelColor;
  final Color buttonColor;

  const ButtonWidget(
      {this.text, this.onClicked, this.labelColor, this.buttonColor});

  @override
  Widget build(BuildContext context) => ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          primary: buttonColor,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
      child: Text(text,
          style: GoogleFonts.montserrat(fontSize: 20, color: labelColor)),
      onPressed: onClicked);
}
