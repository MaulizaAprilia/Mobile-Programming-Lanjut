import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import '../pages/produk_page.dart';
import '../pages/settings_page.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({Key? key}) : super(key: key);

  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  int _selectedIndex = 0;

  final PageStorageBucket _bucket = PageStorageBucket();

  final List<Widget> _pages = [
    HomePage(key: PageStorageKey('HomePage')),
    ProdukPage(key: PageStorageKey('ProdukPage')),
    SettingsPage(key: PageStorageKey('SettingsPage')),
  ];

  void _onTabTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Berpindah ke tab ${_tabTitle(index)}'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  String _tabTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Produk';
      case 2:
        return 'Settings';
      default:
        return '';
    }
  }

  Widget? _buildFAB() {
    switch (_selectedIndex) {
      case 1:
        return FloatingActionButton(
          backgroundColor: const Color(0xFF370505),
          onPressed: () {
            // Aksi khusus produk
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Tambah produk baru')),
            );
          },
          child: Icon(Icons.add),
          tooltip: 'Tambah Produk',
        );
      default:
        return null;
    }
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: const Color(0xFF370505),
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      elevation: 10,
      onTap: _onTabTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Produk'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KASIRKU - ${_tabTitle(_selectedIndex)}'),
        backgroundColor: const Color(0xFF370505),
        automaticallyImplyLeading: false,
      ),
      body: PageStorage(
        bucket: _bucket,
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      ),
      floatingActionButton: _buildFAB(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
