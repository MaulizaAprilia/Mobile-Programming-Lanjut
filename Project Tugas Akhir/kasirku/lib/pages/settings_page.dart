// settings_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_notifier.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    ThemeMode currentMode = themeNotifier.themeMode;

    return Scaffold(
      appBar: AppBar(title: Text('Pengaturan')),
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
                  children: [Text('Aplikasi kasir sederhana berbasis Flutter.')],
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.color_lens),
              title: Text('Tema'),
              subtitle: Text('Atur tema aplikasi'),
              onTap: () => _showThemeDialog(context, currentMode, themeNotifier),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
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

  void _showThemeDialog(BuildContext context, ThemeMode currentMode, ThemeNotifier notifier) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Pilih Tema'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              value: ThemeMode.system,
              groupValue: currentMode,
              onChanged: (mode) {
                notifier.setTheme(mode!);
                Navigator.pop(context);
              },
              title: Text('Sistem'),
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.light,
              groupValue: currentMode,
              onChanged: (mode) {
                notifier.setTheme(mode!);
                Navigator.pop(context);
              },
              title: Text('Terang'),
            ),
            RadioListTile<ThemeMode>(
              value: ThemeMode.dark,
              groupValue: currentMode,
              onChanged: (mode) {
                notifier.setTheme(mode!);
                Navigator.pop(context);
              },
              title: Text('Gelap'),
            ),
          ],
        ),
      ),
    );
  }
}
