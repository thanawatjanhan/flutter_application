import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  // state variable
  String message = 'Hello';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter')),
      body: Text(message),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // debugPrint(message);
          setState(() {
            // message = message == 'Hello' ? 'Hi' : 'Hello';
            if (message == 'Hello') {
              message = 'Hi';
            } else if (message == 'Hi') {
              message = 'Hello World';
            } else {
              message = 'Hello';
            }
          });
        },
        child: Text("Click"),
      ),
    );
  }
}
