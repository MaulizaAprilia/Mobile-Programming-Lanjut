import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  // Dummy data laporan, nanti bisa dikembangkan dengan DB
  final int totalTransactions = 5;
  final double totalRevenue = 150000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan Penjualan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text('Total Transaksi'),
                trailing: Text('$totalTransactions'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.attach_money),
                title: Text('Total Pendapatan'),
                trailing: Text('Rp ${totalRevenue.toStringAsFixed(0)}'),
              ),
            ),
            // Bisa tambah grafik/chart pakai package charts_flutter
          ],
        ),
      ),
    );
  }
}
