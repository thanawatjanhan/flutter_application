import 'package:flutter/material.dart';
import 'dart:math';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  TextEditingController tcNumber1 = TextEditingController();
  TextEditingController tcNumber2 = TextEditingController();

  String message = "";

  bool _isNumeric(String s) {
    return int.tryParse(s) != null;
  }

  void _sum() {
    String text1 = tcNumber1.text;
    String text2 = tcNumber2.text;

    if (text1.isEmpty || text2.isEmpty) {
      setState(() {
        message = "Please inputs both numbers";
      });
      return;
    }

    if (!_isNumeric(text1) || !_isNumeric(text2)) {
      setState(() {
        message = "Please inputs only numbers";
      });
      return;
    }

    int num1 = int.parse(text1);
    int num2 = int.parse(text2);
    int sum = num1 + num2;

    setState(() {
      message = "Result = $sum";
    });
  }

  void _power() {
    String text1 = tcNumber1.text;
    String text2 = tcNumber2.text;

    if (text1.isEmpty || text2.isEmpty) {
      setState(() {
        message = "Please inputs both numbers";
      });
      return;
    }

    if (!_isNumeric(text1) || !_isNumeric(text2)) {
      setState(() {
        message = "Please inputs only numbers";
      });
      return;
    }

    int num1 = int.parse(text1);
    int num2 = int.parse(text2);
    num power = pow(num1, num2);

    setState(() {
      message = "Result = $power";
    });
  }

  void _clear() {
    setState(() {
      tcNumber1.clear();
      tcNumber2.clear();
      message = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Calculator",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: tcNumber1,
              decoration: const InputDecoration(hintText: "Number 1"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: tcNumber2,
              decoration: const InputDecoration(hintText: "Number 2"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _sum,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
              child: const Text("Sum", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _power,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text("Power", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _clear,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Clear", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
