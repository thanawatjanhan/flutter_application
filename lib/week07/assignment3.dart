import 'package:flutter/material.dart';


class Assignment3 extends StatefulWidget {
  const Assignment3({super.key});


  @override
  State<Assignment3> createState() => _Assignment3State();
}


class _Assignment3State extends State<Assignment3> {
  bool isCold = false;
  double sugarValue = 2;
  String selectedCoffee = 'Latte';
  bool showThankU = false;
  void toggleSwitch(bool value) {
    setState(() {
      isCold = value;
    });
  }


  List coffee = [
    {
      'name': 'Latte',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/Latte_with_winged_tulip_art.jpg/250px-Latte_with_winged_tulip_art.jpg',
      'price': 35,
    },
    {
      'name': 'Americano',
      'image':
          'https://secondcup.com/wp-content/uploads/2022/04/Flash-Cold-Brew.jpg',
      'price': 30,
    },
    {
      'name': 'Capuccino',
      'image':
          'https://www.acouplecooks.com/wp-content/uploads/2020/10/how-to-make-cappuccino-005.jpg',
      'price': 40,
    },
  ];
  final Map<double, String> sugarLebels = {0: 'No', 1: 'Less', 2: 'Normal'};
  void showAlert(BuildContext context) async {
    String coffeeType = isCold ? 'Cold' : 'Hot';
    String sugarLevel = sugarLebels[sugarValue] ?? 'Normal';
    var selected = coffee.firstWhere((cf) => cf['name'] == selectedCoffee);
    int price = selected['price'];
    String image = selected['image'];
    if (isCold) price += 5;
    String contentOrderSum =
        '$coffeeType $selectedCoffee with $sugarLevel sugar. Price = $price baht';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Your Order'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(image, height: 150, fit: BoxFit.cover),
              const SizedBox(height: 10),
              Text(contentOrderSum),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  showThankU = false;
                });
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  showThankU = true;
                });
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MFU Coffee Shop', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple[400],
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your Order',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Coffee', style: TextStyle(fontWeight: FontWeight.bold)),
                for (var item in coffee)
                  RadioListTile(
                    title: Text('${item['name']} ${item['price']}'),
                    value: item['name'],
                    groupValue: selectedCoffee,
                    onChanged: (value) {
                      setState(() {
                        selectedCoffee = value.toString();
                      });
                    },
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text('Type', style: TextStyle(fontWeight: FontWeight.bold)),
                Spacer(),
                Row(
                  children: [
                    Text('hot'),
                    Switch(value: isCold, onChanged: toggleSwitch),
                    Text('Cold (+5)'),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Sugar',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Text('None'),
                    Spacer(),
                    Slider(
                      value: sugarValue,
                      max: 2,
                      min: 0,
                      divisions: 2,
                      label: sugarLebels[sugarValue],
                      onChanged: (value) {
                        setState(() {
                          sugarValue = value;
                        });
                      },
                    ),
                    Text('Normal'),
                  ],
                ),
                FilledButton(
                  onPressed: () => showAlert(context),
                  child: Text('ORDER'),
                ),
                const SizedBox(height: 8),
                if (showThankU)
                  const Center(
                    child: Text(
                      'Thank you for your order!',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
