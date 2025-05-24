import 'package:flutter/material.dart';
import 'products_screen.dart';
import 'cart_screen.dart';
import 'report_screen.dart';
import '../models/product.dart';

class HomeScreen extends StatelessWidget {
  final List<Product> sampleProducts = [
    Product(id: '1', name: 'Kopi Tubruk', price: 10000, stock: 20, category: 'Minuman'),
    Product(id: '2', name: 'Teh Manis', price: 8000, stock: 30, category: 'Minuman'),
    Product(id: '3', name: 'Gula 1kg', price: 14000, stock: 15, category: 'Makanan'),
    Product(id: '4', name: 'Air Mineral', price: 5000, stock: 50, category: 'Minuman'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SiKasir - Beranda'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            tooltip: 'Keranjang',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CartScreen(availableProducts: sampleProducts),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.store, size: 48, color: Colors.white),
                  SizedBox(height: 8),
                  Text(
                    'SiKasir Menu',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(context, Icons.home, 'Beranda', '/'),
            _buildDrawerItem(context, Icons.shopping_bag, 'Produk', '/products'),
            _buildDrawerItem(context, Icons.point_of_sale, 'Transaksi', '/transactions'),
            _buildDrawerItem(context, Icons.bar_chart, 'Laporan', '/reports'),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.store_mall_directory, size: 100, color: Colors.indigo),
            SizedBox(height: 24),
            Text(
              'Selamat datang di SiKasir!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Solusi Digitalisasi Transaksi UMKM.\nKelola produk, transaksi & laporan dengan mudah.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CartScreen(availableProducts: sampleProducts),
                  ),
                );
              },
              icon: Icon(Icons.point_of_sale),
              label: Text('Mulai Transaksi'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.indigo),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, route);
      },
    );
  }
}
