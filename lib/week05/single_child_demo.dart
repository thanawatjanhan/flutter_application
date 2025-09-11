import 'package:flutter/material.dart';

class SingleChildDemo extends StatelessWidget {
  const SingleChildDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Single Child Demo")),
      body: SafeArea(
        // Align is (x, y) -1 ≤ x ≤ 1, -1 ≤ y ≤ 1 and (0, 0) is at the parent's center
        child: Align(alignment: Alignment(-1, -1), child: Text("Single Child")),
      ),
    );
  }
}
