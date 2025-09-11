import 'package:flutter/material.dart';

class SingleChildDemo extends StatelessWidget {
  const SingleChildDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Single Child Demo")),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          color: Colors.amber,
          width: 150,
          height: 100,
          alignment: Alignment.center,
          child: Text("Single Child"),
        ),
      ),
    );
  }
}
