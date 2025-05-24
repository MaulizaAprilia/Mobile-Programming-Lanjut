import 'package:flutter/material.dart';
import '../models/product.dart';

class TransactionScreen extends StatefulWidget {
  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final List<Product> _products = [
  Product(id: '1', name: 'Kopi Tubruk', price: 10000, stock: 30, category: 'Minuman'),
  Product(id: '2', name: 'Teh Manis', price: 8000, stock: 25, category: 'Minuman'),
  Product(id: '3', name: 'Roti Bakar', price: 15000, stock: 15, category: 'Makanan'),
];


  Map<Product, int> _cart = {};

  double get totalPrice {
    double total = 0;
    _cart.forEach((product, qty) {
      total += product.price * qty;
    });
    return total;
  }

  void _addToCart(Product product) {
    setState(() {
      _cart.update(product, (qty) => qty + 1, ifAbsent: () => 1);
    });
  }

  void _removeFromCart(Product product) {
    setState(() {
      if (_cart.containsKey(product)) {
        if (_cart[product]! > 1) {
          _cart[product] = _cart[product]! - 1;
        } else {
          _cart.remove(product);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transaksi Penjualan')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: _products.map((product) {
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('Harga: Rp ${product.price.toStringAsFixed(0)}'),
                  trailing: ElevatedButton(
                    child: Text('Tambah'),
                    onPressed: () => _addToCart(product),
                  ),
                );
              }).toList(),
            ),
          ),
          Divider(),
          if (_cart.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Keranjang:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ..._cart.entries.map((entry) {
              final product = entry.key;
              final qty = entry.value;
              return ListTile(
                title: Text('${product.name} x$qty'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => _removeFromCart(product),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => _addToCart(product),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
          Divider(),
          ListTile(
            title: Text('Total:'),
            trailing: Text(
              'Rp ${totalPrice.toStringAsFixed(0)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: ElevatedButton(
              child: Text('Bayar'),
              onPressed: _cart.isEmpty
                  ? null
                  : () {
                      setState(() {
                        _cart.clear();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Transaksi berhasil!')),
                      );
                    },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
