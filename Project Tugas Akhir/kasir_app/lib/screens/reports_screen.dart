import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Laporan')),
      body: const Center(
        child: Text('Halaman Laporan Penjualan', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
