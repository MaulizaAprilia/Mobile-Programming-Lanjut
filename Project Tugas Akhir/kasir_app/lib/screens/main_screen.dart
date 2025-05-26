import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Menu Kasir', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Beranda'),
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_basket),
            title: const Text('Produk'),
            onTap: () => Navigator.pushReplacementNamed(context, '/products'),
          ),
          ListTile(
            leading: const Icon(Icons.point_of_sale),
            title: const Text('Penjualan'),
            onTap: () => Navigator.pushReplacementNamed(context, '/sales'),
          ),
          ListTile(
            leading: const Icon(Icons.report),
            title: const Text('Laporan'),
            onTap: () => Navigator.pushReplacementNamed(context, '/reports'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Pengaturan'),
            onTap: () => Navigator.pushReplacementNamed(context, '/settings'),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Keranjang'),
            onTap: () => Navigator.pushReplacementNamed(context, '/cart'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kasir App - Beranda'),
      ),
      drawer: _buildDrawer(context),
      body: const Center(
        child: Text(
          'Selamat datang di aplikasi Kasir!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
