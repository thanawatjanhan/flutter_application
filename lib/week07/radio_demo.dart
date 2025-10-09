import 'package:flutter/material.dart';

class RadioDemo extends StatefulWidget {
  const RadioDemo({super.key});

  @override
  State<RadioDemo> createState() => _RadioDemoState();
}

class _RadioDemoState extends State<RadioDemo> {
  int radio1 = 1;
  List colors = ["Red", "Green", "Yellow", "Blue", "Black", "White"];

  List<Widget> createRadio() {
    // List<Widget> radios = [];
    // for (int i = 0; i < colors.length; i++) {
    //   radios.add(Radio(value: i, groupValue: radio1, onChanged: updateRadio1));
    //   radios.add(Text(colors[i]));
    // }

    List<Widget> radios = List.generate(
      colors.length,
      (index) =>
          Radio(value: index, groupValue: radio1, onChanged: updateRadio1),
    );

    radios.add(SizedBox(width: 20));
    radios.add(Text("You choose $radio1"));
    return radios;
  }

  void updateRadio1(int? value) {
    setState(() {
      radio1 = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [Wrap(children: createRadio())]),
      ),
    );
  }
}
