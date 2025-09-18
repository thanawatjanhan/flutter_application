import 'package:flutter/material.dart';

class ButtonDemo extends StatelessWidget {
  const ButtonDemo({super.key});

  Widget createIconButton() {
    return OverflowBar(
      alignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.volume_up, color: Colors.red),
          onPressed: () {
            debugPrint("IconButton");
          },
        ),
        Ink(
          decoration: ShapeDecoration(
            shape: CircleBorder(),
            color: Colors.blue,
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.android, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget createOutlineButton() {
    return OverflowBar(
      children: [
        OutlinedButton(onPressed: () {}, child: Text("OutlinedButton")),
        SizedBox(width: 8),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.red,
            backgroundColor: Colors.amber,
          ),
          child: Text("OutlinedButton"),
        ),
      ],
    );
  }

  Widget creteButtons() {
    return OverflowBar(
      children: [
        TextButton(onPressed: () {}, child: Text("Text Button")),
        ElevatedButton(onPressed: () {}, child: Text("Elevated Button")),
        FilledButton(onPressed: () {}, child: Text("Filled Button")),
        FilledButton(
          onPressed: () {},
          style: FilledButton.styleFrom(foregroundColor: Colors.red),
          child: Text("Filled Button"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16),
            createIconButton(),
            Divider(),
            createOutlineButton(),
            Divider(),
            creteButtons(),
          ],
        ),
      ),
    );
  }
}
