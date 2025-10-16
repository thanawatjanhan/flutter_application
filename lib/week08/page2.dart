import 'package:flutter/material.dart';
import 'package:flutter_application_1/week08/page1.dart';

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
              // clear session and remove local storage

              // return to previous page
              Navigator.pop(context);
            },
            child: const Text('Back'),
          ),
          FilledButton(
            onPressed: () {
              // return to previous page
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Page1()),
                (route) => false,
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
