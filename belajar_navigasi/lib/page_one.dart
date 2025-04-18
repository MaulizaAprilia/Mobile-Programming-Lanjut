import 'package:flutter/material.dart';
import 'page_two.dart';

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Page One")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PageTwo()),
            );
          },
          child: Text("Go to Page Two"),
        ),
      ),
    );
  }
}
