import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold supaya bisa pakai AppBar jika dipanggil standalone (opsional)
      appBar: AppBar(
        title: Text('Pengaturan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Tentang Aplikasi'),
              subtitle: Text('KASIRKU versi 1.0.0'),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'KASIRKU',
                  applicationVersion: '1.0.0',
                  applicationIcon: Icon(Icons.point_of_sale, size: 40),
                  children: [
                    Text('Aplikasi kasir sederhana berbasis Flutter.'),
                  ],
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.color_lens),
              title: Text('Tema'),
              subtitle: Text('Atur tema aplikasi'),
              onTap: () {
                // Contoh: nanti bisa tambah pengaturan tema
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Fitur tema belum tersedia')),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Logika logout bisa ditaruh sini
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logout belum diimplementasikan')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
