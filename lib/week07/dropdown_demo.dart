import 'package:flutter/material.dart';

class DropdownDemo extends StatefulWidget {
  const DropdownDemo({super.key});

  @override
  State<DropdownDemo> createState() => _DropdownDemoState();
}

class _DropdownDemoState extends State<DropdownDemo> {
  String dropValue = "red";

  void updateDropdown(String? value) {
    setState(() {
      dropValue = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            DropdownButton(
              value: dropValue,
              items: [
                DropdownMenuItem(value: "red", child: Text("Red")),
                DropdownMenuItem(value: "green", child: Text("Green")),
                DropdownMenuItem(value: "blue", child: Text("Blue")),
              ],
              onChanged: updateDropdown,
            ),
          ],
        ),
      ),
    );
  }
}
