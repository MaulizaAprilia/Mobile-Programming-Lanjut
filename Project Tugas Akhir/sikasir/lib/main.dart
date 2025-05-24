import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/products_screen.dart';
import 'screens/transaction_screen.dart';
import 'screens/report_screen.dart';

void main() {
  runApp(SiKasirApp());
}

class SiKasirApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiKasir',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        cardTheme: CardTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/products': (context) => ProductsScreen(),
        '/transactions': (context) => TransactionScreen(),
        '/reports': (context) => ReportScreen(),
      },
    );
  }
}
