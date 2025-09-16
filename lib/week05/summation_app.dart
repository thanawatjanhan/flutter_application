import 'package:flutter/material.dart';

class SummationApp extends StatefulWidget {
  const SummationApp({super.key});

  @override
  State<SummationApp> createState() => _SummationAppState();
}

class _SummationAppState extends State<SummationApp> {
  TextEditingController tcNumber1 = TextEditingController();
  TextEditingController tcNumber2 = TextEditingController();

  String message = "";

  bool _isNumeric(String s) {
    return int.tryParse(s) != null;
  }

  void _sum() {
    String text1 = tcNumber1.text;
    String text2 = tcNumber2.text;

    if (text1.isEmpty || text2.isEmpty || !_isNumeric(text1) || !_isNumeric(text2)) {
      setState(() {
        message = "Incorrect input";
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
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 130,
                      child: TextField(
                        controller: tcNumber1,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(hintText: "First Number"),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("+"),
                    ),
                    SizedBox(
                      width: 130,
                      child: TextField(
                        controller: tcNumber2,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(hintText: "Second Number"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 110,
                      child: ElevatedButton(
                        onPressed: _sum,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                        child: const Text("Calculate", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 90,
                      child: ElevatedButton(
                        onPressed: _clear,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: const Text("Clear", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  message,
                  style: const TextStyle(fontSize: 16, color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
