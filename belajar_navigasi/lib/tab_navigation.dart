import 'package:flutter/material.dart';

class TabNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tab Navigation'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Home"),
              Tab(icon: Icon(Icons.settings), text: "Settings"),
              Tab(icon: Icon(Icons.person), text: "Profile"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text('Home Tab')),
            Center(child: Text('Settings Tab')),
            Center(child: Text('Profile Tab')),
          ],
        ),
      ),
    );
  }
}
