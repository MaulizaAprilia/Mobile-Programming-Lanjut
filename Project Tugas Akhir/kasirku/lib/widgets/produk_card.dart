import 'package:flutter/material.dart';

class ProdukCard extends StatelessWidget {
  final String nama;
  final int harga;
  final String gambar;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProdukCard({
    required this.nama,
    required this.harga,
    required this.gambar,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      image: AssetImage(gambar),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 4,
                  top: 4,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: Icon(Icons.star, color: Colors.yellow, size: 18),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(nama, style: Theme.of(context).textTheme.titleLarge),
                Text("Rp$harga", style: Theme.of(context).textTheme.bodyMedium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(icon: Icon(Icons.edit), onPressed: onEdit),
                    IconButton(icon: Icon(Icons.delete), onPressed: onDelete),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
