import 'package:flutter/material.dart';
import 'produk_page.dart';
import 'transaksi_page.dart';
import '../tabs/tab_navigator.dart';

class HomePage extends StatelessWidget {
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
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [const Color.fromARGB(255, 55, 5, 5), const Color.fromARGB(255, 89, 7, 7)]),
              ),
              child: Column(
                children: [
                  CircleAvatar(radius: 30, backgroundColor: Colors.white,),
                  SizedBox(height: 10),
                  Text('Admin Kasir', style: TextStyle(color: Colors.white, fontSize: 18))
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Beranda'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.inventory),
              title: Text('Kelola Produk'),
              onTap: () => navigateTo(context, ProdukPage()),
            ),
            ListTile(
              leading: Icon(Icons.point_of_sale),
              title: Text('Transaksi'),
              onTap: () => navigateTo(context, TransaksiPage()),
            ),
            ListTile(
              leading: Icon(Icons.tab),
              title: Text('Tab Navigasi'),
              onTap: () => navigateTo(context, TabNavigator()),
            ),
          ],
        ),
      ),
      appBar: AppBar(title: Text("KASIRKU")),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [const Color.fromARGB(255, 255, 255, 255), Colors.white],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => navigateTo(context, ProdukPage()),
                  child: Text('Kelola Produk'),
                ),
                SizedBox(height: 12), // Jarak antar tombol

                ElevatedButton(
                  onPressed: () => navigateTo(context, TransaksiPage()),
                  child: Text('Transaksi Baru'),
                ),
                SizedBox(height: 12), // Jarak antar tombol

                ElevatedButton(
                  onPressed: () => navigateTo(context, TabNavigator()),
                  child: Text('Lihat Halaman Tab'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}