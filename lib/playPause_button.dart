import 'package:flutter/material.dart';
import 'package:timer_app/shared/constants.dart';

class PlayPauseButton extends StatelessWidget {
  final VoidCallback onClicked;
  final bool runState;

  const PlayPauseButton({Key key, this.onClicked, this.runState})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            primary: themeBlackLight,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        child: Container(
            // color: Colors.white,
            height: 35,
            width: 35,
            child: Center(
                child: runState
                    ? Icon(
                        Icons.pause,
                        color: Colors.white,
                        size: 35,
                      )
                    : Icon(Icons.play_arrow, color: Colors.white, size: 35))),
        onPressed: onClicked,
      );
}
