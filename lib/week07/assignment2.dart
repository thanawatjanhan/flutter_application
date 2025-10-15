import 'package:flutter/material.dart';


class Assignment2 extends StatefulWidget {
  const Assignment2({super.key});


  @override
  State<Assignment2> createState() => _Assignment2State();
}


class _Assignment2State extends State<Assignment2> {
  bool isCold = false;
  double sugarValue = 2;


  final Map<double, String> sugarLabels = {
    0: 'No',
    1: 'Less',
    2: 'Normal',
  };


  void toggleSwitch(bool value) {
    setState(() {
      isCold = value;
    });
  }


  void showAlert(BuildContext context) async {
    String coffeeType = isCold ? 'Cold' : 'Hot';
    String sugarLevel = sugarLabels[sugarValue] ?? 'Normal';
    String contentOrderSum = '$coffeeType coffee with $sugarLevel sugar';


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Your Order'),
          content: Text(contentOrderSum),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MFU Coffee Shop',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple[400],
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Your Order',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Type'),
                const Spacer(),
                Row(
                  children: [
                    const Text('Hot'),
                    Switch(value: isCold, onChanged: toggleSwitch),
                    const Text('Cold'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Sugar level'),
                    const Spacer(),
                    Slider(
                      value: sugarValue,
                      max: 2,
                      min: 0,
                      divisions: 2,
                      label: sugarLabels[sugarValue],
                      onChanged: (value) {
                        setState(() {
                          sugarValue = value;
                        });
                      },
                    ),
                    const Text('Normal'),
                  ],
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () => showAlert(context),
                  child: const Text('ORDER'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
