import 'package:flutter/material.dart';
import 'produk_page.dart';
import 'transaksi_page.dart';
import '../tabs/tab_navigator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void navigateTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 55, 5, 5),
                    Color.fromARGB(255, 89, 7, 7),
                  ],
                ),
              ),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Admin Kasir',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Beranda'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text('Kelola Produk'),
              onTap: () => navigateTo(context,  ProdukPage()),
            ),
            ListTile(
              leading: const Icon(Icons.point_of_sale),
              title: const Text('Transaksi'),
              onTap: () => navigateTo(context, TransaksiPage()),
            ),
            ListTile(
              leading: const Icon(Icons.tab),
              title: const Text('Tab Navigasi'),
              onTap: () => navigateTo(context, const TabNavigator()),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("KASIRKU"),
        backgroundColor: const Color(0xFF370505),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFF7F7F7)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/kasir_logo1.jpg',
              height: 100,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            const Text(
              "Selamat Datang di KASIRKU",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF370505),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              "Kelola produk, buat transaksi, dan navigasi dengan mudah.",
              style: TextStyle(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: 220,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.inventory, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF370505),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(0, 48),
                        ),
                        onPressed: () => navigateTo(context, ProdukPage()),
                        label: const Text('Kelola Produk'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: 220,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.point_of_sale, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF370505),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(0, 48),
                        ),
                        onPressed: () => navigateTo(context, TransaksiPage()),
                        label: const Text('Transaksi Baru'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: 220,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.tab, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF370505),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(0, 48),
                        ),
                        onPressed: () => navigateTo(context, const TabNavigator()),
                        label: const Text('Lihat Halaman Tab'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
