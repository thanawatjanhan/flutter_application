import 'package:flutter/material.dart';

import 'fruit.dart';

class Page2 extends StatelessWidget {
  final Fruit fruit;

  // Constructor
  Page2({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> data =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(title: const Text("Page 2")),
      body: Column(
        children: [
          // Text("Name: ${data['name']}"),
          // Text("Price: ${data['price']}"),
          // Text("Manufacture: ${data['date'][0]}"),
          // Text("Expire: ${data['date'][1]}"),
          Text("Name: ${fruit.name}"),
          Text("Price: ${fruit.price}"),
          Text("Manufacture: ${fruit.date[0]}"),
          Text("Expire: ${fruit.date[1]}"),
          FilledButton(
            onPressed: () {
              // return to previous page
              Navigator.pop(context);
            },
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }
}
