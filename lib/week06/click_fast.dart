import 'dart:async';
import 'package:flutter/material.dart';

class ClickFast extends StatefulWidget {
  const ClickFast({super.key});

  @override
  State<ClickFast> createState() => _ClickFastState();
}

class _ClickFastState extends State<ClickFast> {
  double timeLeft = 1.00;
  int clickCount = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void startCountdown() {
    timer?.cancel();
    setState(() {
      timeLeft = 1.00;
      clickCount = 0;
    });

    timer = Timer.periodic(const Duration(milliseconds: 10), (t) {
      setState(() {
        timeLeft -= 0.01;
        if (timeLeft <= 0) {
          timeLeft = 0;
          timer?.cancel();
        }
      });
    });
  }

  void incrementClick() {
    if (timeLeft > 0) {
      setState(() {
        clickCount++;
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                timeLeft.toStringAsFixed(2),
                style: const TextStyle(fontSize: 20, color: Colors.red),
              ),
              const SizedBox(height: 5),
              Text('Click = $clickCount', style: const TextStyle(fontSize: 30)),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: incrementClick,
                    icon: const Icon(Icons.touch_app),
                    label: const Text('Click'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: startCountdown,
                    icon: const Icon(Icons.refresh, color: Colors.black),
                    label: const Text(
                      'PLAY',
                      style: TextStyle(color: Colors.red),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
