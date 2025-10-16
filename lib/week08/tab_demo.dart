import 'package:flutter/material.dart';

class TabDemo extends StatefulWidget {
  const TabDemo({super.key});

  @override
  State<TabDemo> createState() => _TabDemoState();
}

class _TabDemoState extends State<TabDemo> {
  String msg1 = "Home";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tab Demo"),
          // bottom: TabBar(
          //   tabs: [
          //     Tab(icon: Icon(Icons.home), text: "Home"),
          //     Tab(icon: Icon(Icons.train), text: "Train"),
          //     Tab(icon: Icon(Icons.directions_bike), text: "Bike"),
          //   ],
          // ),
        ),
        bottomNavigationBar: Container(
          color: Colors.grey[300],
          child: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Home"),
              Tab(icon: Icon(Icons.train), text: "Train"),
              Tab(icon: Icon(Icons.directions_bike), text: "Bike"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(color: Colors.yellow, child: Text("Home")),
            Container(color: Colors.green, child: Icon(Icons.access_alarm)),
            Container(
              color: Colors.orange,
              child: Row(
                children: [
                  FilledButton(
                    onPressed: () {
                      setState(() {
                        msg1 = "Changed!";
                      });
                    },
                    child: Text("OK"),
                  ),
                  FilledButton(onPressed: () {}, child: Text("Cancel")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
