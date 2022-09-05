import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimerFunctions extends StatelessWidget {
  TimerFunctions(
      {required this.timer, required this.functionName, required this.Click});
  final StopWatchTimer timer;
  final String functionName;
  final Function Click;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 10,
      child: Text(
        functionName,
        style: TextStyle(
            fontSize: 45, color: Colors.black, fontWeight: FontWeight.w900),
        textAlign: TextAlign.center,
      ),
      color: Color(0xFFFFB562),
      onPressed: () {
        Click();
      },
    );
  }
}
