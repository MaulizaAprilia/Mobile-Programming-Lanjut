import 'package:flutter/material.dart';
import 'pages/home_page.dart';

// Custom MaterialColor untuk warna merah gelap
MaterialColor customSwatch = const MaterialColor(
  0xFF370505,
  <int, Color>{
    50: Color(0xFFF2E6E6),
    100: Color(0xFFDAB3B3),
    200: Color(0xFFC18080),
    300: Color(0xFFA84D4D),
    400: Color(0xFF943333),
    500: Color(0xFF370505),
    600: Color(0xFF300404),
    700: Color(0xFF270303),
    800: Color(0xFF1F0202),
    900: Color(0xFF130101),
  },
);

void main() {
  runApp(KasirkuApp());
}

class KasirkuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KASIRKU',
      theme: ThemeData(
        primarySwatch: customSwatch,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF370505),
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        appBarTheme: const AppBarTheme(
          color: Color(0xFF370505),
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(
            color: Colors.white, // Ubah warna ikon seperti hamburger/menu
          ),
        ),
        cardTheme: const CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          elevation: 4,
          margin: EdgeInsets.all(8),
        ),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
