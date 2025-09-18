import 'package:flutter/material.dart';

const Color bgColor = Color(0xFF202020);
const Color primaryColor = Color(0xFFFFBD73);

class BakingApp extends StatelessWidget {
  const BakingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image
          Expanded(
            flex: 6,
            child: Image.asset("assets/images/baking.jpg", fit: BoxFit.cover),
          ),
          // Text with button
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Spacer(),
                Text(
                  "Baking Lessons".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Master the art of baking".toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                Spacer(),
                FilledButton.icon(
                  onPressed: () {},
                  label: Text(
                    "Start learning".toUpperCase(),
                    style: TextStyle(color: bgColor),
                  ),
                  icon: Icon(Icons.arrow_forward, color: bgColor),
                  iconAlignment: IconAlignment.end,
                  style: FilledButton.styleFrom(backgroundColor: primaryColor),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
