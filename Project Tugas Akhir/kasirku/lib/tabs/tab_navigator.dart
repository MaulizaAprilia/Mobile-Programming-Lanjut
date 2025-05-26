import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import '../pages/produk_page.dart';
import '../pages/settings_page.dart';

/// TabNavigator widget mengelola tab bar navigation dengan tiga tab utama:
/// - Home
/// - Produk
/// - Settings
///
/// Digunakan di halaman utama (HomePage) yang memakai bottom navigation bar atau tab bar.
class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> _tabs = [
    Tab(icon: Icon(Icons.home), text: 'Home'),
    Tab(icon: Icon(Icons.inventory), text: 'Produk'),
    Tab(icon: Icon(Icons.settings), text: 'Settings'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KASIRKU'),
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs,
          labelColor: Colors.white,               // warna teks icon dan label saat dipilih
          unselectedLabelColor: Colors.white70,   // warna teks icon dan label saat tidak dipilih
          indicatorColor: Colors.white,            // warna garis di bawah tab aktif
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          HomePage(),
          ProdukPage(),
          SettingsPage(),
        ],
      ),
      drawer: _buildDrawer(context),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: const Color(0xFF370505)),
            child: Text(
              'Menu Kasirku',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: const Color(0xFF370505)),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              _tabController.animateTo(0);
            },
          ),
          ListTile(
            leading: Icon(Icons.inventory, color: const Color(0xFF370505)),
            title: Text('Produk'),
            onTap: () {
              Navigator.pop(context);
              _tabController.animateTo(1);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: const Color(0xFF370505)),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              _tabController.animateTo(2);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Keluar'),
            onTap: () {
              // Logika logout atau keluar aplikasi
              Navigator.pop(context);
              // Misal keluar aplikasi atau ke halaman login
            },
          ),
        ],
      ),
    );
  }
}
