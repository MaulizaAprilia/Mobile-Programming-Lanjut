import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  String _displayText = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(150, 9, 153, 117), // Warna latar belakang
        appBar: AppBar(title: const Text('App - Mauliza Aprilia')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Pusatkan elemen di tengah
          children: [
            const Text(
              'Welcome to My App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
                shadows: [
                  Shadow(
                    blurRadius: 5.0,
                    color: Colors.black45,
                    offset: Offset(3.0, 3.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Spasi antara teks dan ikon
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.star, size: 50, color: Colors.amber),
                SizedBox(width: 15), // Spasi antar ikon
                Icon(Icons.favorite, size: 50, color: Color.fromARGB(255, 176, 38, 28)),
                SizedBox(width: 15),
                Icon(Icons.home, size: 50, color: Colors.blue),
                SizedBox(width: 15),
                Icon(Icons.settings, size: 50, color: Colors.grey),
                SizedBox(width: 15),
                Icon(Icons.person, size: 50, color: Colors.green),
              ],
            ),
            const SizedBox(height: 20), // Spasi sebelum menampilkan gambar

            // Menampilkan gambar
            Center(
              child: Column(
                children: [
                  Image.asset('assets/1.jpg', width: 200), // Gambar dari assets
                  const SizedBox(height: 10), // Spasi antara gambar
                  Image.network(
                    'https://unp.ac.id/patch/images/800/88c55c3c3da3b19e7b7939feedaceb35.png',
                    width: 200,
                  ), // Gambar dari URL
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Input Field (TextField)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Enter your name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            // Tombol untuk Menampilkan Input
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _displayText = _controller.text;
                });
              },
              child: const Text('Tampilkan Nama'),
            ),

            const SizedBox(height: 5),

            // Menampilkan Hasil Input
            Text(
              _displayText,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
