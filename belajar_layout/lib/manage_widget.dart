import 'package:flutter/material.dart';

class ManageWidget extends StatefulWidget {
  const ManageWidget({super.key});

  @override
  _ManageWidgetState createState() => _ManageWidgetState();
}

class _ManageWidgetState extends State<ManageWidget> {
  bool _isVisible = true;

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Widget')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500), // Durasi animasi
              opacity: _isVisible ? 1.0 : 0.0, // Opacity berubah saat ditoggle
              child: Container(
                width: 150,
                height: 150,
                color: Colors.green,
                child: const Center(
                  child: Text(
                    'Visible Widget',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleVisibility,
              child: const Text('Toggle Visibility'),
            ),
          ],
        ),
      ),
    );
  }
}
