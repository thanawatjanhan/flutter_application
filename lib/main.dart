import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('My First App')),
        body: Text('Hello, World!'),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          child: Text("Click"),
        ),
      ),
    ),
  );
}
