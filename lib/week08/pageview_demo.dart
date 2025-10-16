import 'package:flutter/material.dart';

class PageviewDemo extends StatelessWidget {
  PageviewDemo({super.key});

  PageController pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.9,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pageview")),
      body: SafeArea(
        child: PageView(
          children: [
            Container(color: Colors.yellow, child: Text("Page 1")),
            Container(color: Colors.cyan, child: Text("Page 2")),
            Container(color: Colors.orange, child: Text("Page 3")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pageController.jumpToPage(1);
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.arrow_forward, color: Colors.white),
      ),
    );
  }
}
