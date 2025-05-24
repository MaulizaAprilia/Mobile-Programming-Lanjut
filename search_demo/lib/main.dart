import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Halaman NestedScrollView',
      home: const NestedScrollExample(),
    );
  }
}

class NestedScrollExample extends StatelessWidget {
  const NestedScrollExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: const Text("NestedScrollView"),
                background: Image.network(
                  // Gambar baru:
                  "https://raw.githubusercontent.com/MaulizaAprilia/maulizaaprla/main/Header_liza%20(1).png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: ListView.builder(
          itemCount: 21, // total: 20 item + 1 tombol
          itemBuilder: (context, index) {
            // Tambahkan tombol di akhir list
            if (index == 20) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Tombol ditekan!")),
                      );
                    },
                    child: const Text("Enter"),
                  ),
                ),
              );
            }

            return ListTile(
              title: Text("Item ${index + 1}"),
            );
          },
        ),
      ),
    );
  }
}
