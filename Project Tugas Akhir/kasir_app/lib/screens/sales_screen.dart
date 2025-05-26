import 'package:flutter/material.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Penjualan')),
      body: const Center(
        child: Text('Halaman Penjualan', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
