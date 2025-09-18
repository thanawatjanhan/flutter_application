import 'dart:async';

import 'package:flutter/material.dart';

class TimeDemo extends StatefulWidget {
  const TimeDemo({super.key});

  @override
  State<TimeDemo> createState() => _TimeDemoState();
}

class _TimeDemoState extends State<TimeDemo> {
  String message = "Start";

  @override
  void initState() {
    super.initState();
    // create a countdown Timer
    // Timer(Duration(seconds: 3), () {
    //   setState(() {
    //     message = "Stop";
    //   });
    // });
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        message = "Stop";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(message, style: TextStyle(fontSize: 24)),
          ),
        ),
      ),
    );
  }
}
