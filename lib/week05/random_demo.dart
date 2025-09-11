import 'package:flutter/material.dart';
import 'dart:math';

class RandomDemo extends StatefulWidget {
  const RandomDemo({super.key});

  @override
  State<RandomDemo> createState() => _RandomDemoState();
}

class _RandomDemoState extends State<RandomDemo> {
  TextEditingController tcMin = TextEditingController();
  TextEditingController tcMax = TextEditingController();
  String result = "";

  void generateRandom() {
    int? min = int.tryParse(tcMin.text);
    int? max = int.tryParse(tcMax.text);
    if (min == null || max == null) {
      // debugPrint("Wrong Input");
      setState(() {
        result = "Wrong Input";
      });
      return;
    }
    int random = min + Random().nextInt(max - min + 1);
    // debugPrint(result.toString());
    setState(() {
      result = random.toString();
    });
  }

  void clear() {
    tcMin.clear();
    tcMax.clear();
    setState(() {
      result = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("Random Integer Number"),
              TextField(
                controller: tcMin,
                decoration: InputDecoration(hintText: "min"),
              ),
              TextField(
                controller: tcMax,
                decoration: InputDecoration(hintText: "max"),
              ),
              Text(result),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    onPressed: generateRandom,
                    child: Text("Generate"),
                  ),
                  FilledButton(onPressed: clear, child: Text("Clear")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
