import 'package:flutter/material.dart';

class CbSwDemo extends StatefulWidget {
  const CbSwDemo({super.key});

  @override
  State<CbSwDemo> createState() => _CbSwDemoState();
}

class _CbSwDemoState extends State<CbSwDemo> {
  // state variable for a checkbox
  bool cb = false;

  // state variable for a switch
  bool sw = false;

  // method to upadate a checkbox
  void updateCb(bool? value) {
    // print(value!);
    setState(() {
      cb = value!;
    });
  }

  // method to update a switch
  void updateSw(bool? value) {
    // print(value);
    setState(() {
      sw = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(value: cb, onChanged: updateCb),
                Text("Red"),
                SizedBox(width: 20),
                Text("checkbox status: $cb"),
              ],
            ),
            Row(
              children: [
                Switch(value: sw, onChanged: updateSw),
                Text("Football"),
                SizedBox(width: 20),
                Text("Switch status: $sw"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
