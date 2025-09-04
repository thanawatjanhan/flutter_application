import 'package:flutter/material.dart';

class Basic extends StatelessWidget {
  const Basic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My First App')),
      body: Text('Hello, World!'),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Text("Click"),
      ),
    );
  }
}
