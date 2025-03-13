import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  String _displayText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(150, 9, 153, 117),
      appBar: AppBar(title: const Text('App - Mauliza Aprilia')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Welcome to My App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 5.0,
                    color: Colors.black45,
                    offset: Offset(3.0, 3.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Ikon menu
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.star, size: 50, color: Colors.amber),
                SizedBox(width: 15),
                Icon(Icons.favorite, size: 50, color: Colors.red),
                SizedBox(width: 15),
                Icon(Icons.home, size: 50, color: Colors.blue),
                SizedBox(width: 15),
                Icon(Icons.settings, size: 50, color: Colors.grey),
                SizedBox(width: 15),
                Icon(Icons.person, size: 50, color: Colors.green),
              ],
            ),
            const SizedBox(height: 20),

            // Menampilkan gambar
            Column(
              children: [
                Image.asset('assets/1.jpg', width: 200, fit: BoxFit.cover),
                const SizedBox(height: 10),
                Image.network(
                  'https://unp.ac.id/patch/images/800/88c55c3c3da3b19e7b7939feedaceb35.png',
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Input Field (TextField)
            TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Enter your name',
                labelStyle: const TextStyle(color: Colors.white),
                hintText: 'Enter your name',
                hintStyle: const TextStyle(color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Tombol untuk Menampilkan Input
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _displayText = _controller.text;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Nama ditampilkan: $_displayText'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Tampilkan Nama'),
            ),

            const SizedBox(height: 10),

            // Menampilkan Hasil Input
            Text(
              _displayText,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            // Demo Button Section dengan Navigasi ke Halaman Baru
            Column(
              children: [
                _buildNavigationButton(context, 'Raised Button', const RaisedButtonPage()),
                _buildNavigationButton(context, 'Flat Button', const FlatButtonPage()),
                _buildNavigationButton(context, 'Icon Button', const IconButtonPage()),
                _buildNavigationButton(context, 'Floating Action Button', const FloatingActionButtonPage()),
                _buildNavigationButton(context, 'Cupertino Button', const CupertinoButtonPage()),
                _buildNavigationButton(context, 'Custom Gesture', const CustomGesturePage()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk Membuat Tombol dengan Navigasi
  Widget _buildNavigationButton(BuildContext context, String title, Widget page) {
    return Column(
      children: [
        SizedBox(
          width: 220,
          height: 45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10),
              textStyle: const TextStyle(fontSize: 16),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => page));
            },
            child: Text(title),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

// Halaman Raised Button
class RaisedButtonPage extends StatelessWidget {
  const RaisedButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Raised Button Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Raised Button Clicked!'),
        ),
      ),
    );
  }
}

// Halaman Flat Button
class FlatButtonPage extends StatelessWidget {
  const FlatButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flat Button Page')),
      body: Center(
        child: TextButton(
          onPressed: () {},
          child: const Text('Flat Button Clicked!'),
        ),
      ),
    );
  }
}

// Halaman Icon Button
class IconButtonPage extends StatelessWidget {
  const IconButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Icon Button Page')),
      body: Center(
        child: IconButton(
          icon: const Icon(Icons.thumb_up, size: 40, color: Colors.blue),
          onPressed: () {},
        ),
      ),
    );
  }
}

// Halaman Floating Action Button
class FloatingActionButtonPage extends StatelessWidget {
  const FloatingActionButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Floating Action Button Page')),
      floatingActionButton: FloatingActionButton(
         onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Floating Action Button Clicked!')),
         );
       },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Halaman Cupertino Button
class CupertinoButtonPage extends StatelessWidget {
  const CupertinoButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cupertino Button Page')),
      body: const Center(child: Text('Ini adalah halaman Cupertino Button')),
    );
  }
}

// Halaman Custom Gesture
class CustomGesturePage extends StatelessWidget {
  const CustomGesturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Gesture Page')),
      body: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gesture Detected!')),
          );
        },
        child: const Center(child: Text('Tap anywhere!')),
      ),
    );
  }
}
