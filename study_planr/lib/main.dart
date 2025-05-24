import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const StudyPlanrApp());
}

class StudyPlanrApp extends StatelessWidget {
  const StudyPlanrApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudyPlanr',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.light,
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}


