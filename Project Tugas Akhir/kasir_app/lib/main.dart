import 'package:flutter/material.dart';

import 'screens/main_screen.dart';
import 'screens/products_screen.dart';
import 'screens/sales_screen.dart';
import 'screens/reports_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/cart_screen.dart';

void main() {
  runApp(const KasirApp());
}

class KasirApp extends StatelessWidget {
  const KasirApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kasir App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/products': (context) => const ProductsScreen(),
        '/sales': (context) => const SalesScreen(),
        '/reports': (context) => const ReportsScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/cart': (context) => const CartScreen(),
      },
    );
  }
}
