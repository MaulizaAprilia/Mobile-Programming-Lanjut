import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';
import '../widgets/cart_item_title.dart';

class CartScreen extends StatefulWidget {
  final List<Product> availableProducts;

  CartScreen({required this.availableProducts});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<CartItem> _cartItems = [];

  void _addToCart(Product product) {
    setState(() {
      final index = _cartItems.indexWhere((item) => item.product.id == product.id);
      if (index != -1) {
        _cartItems[index].quantity += 1;
      } else {
        _cartItems.add(CartItem(product: product));
      }
    });
  }

  void _increment(CartItem item) {
    setState(() {
      item.quantity += 1;
    });
  }

  void _decrement(CartItem item) {
    setState(() {
      if (item.quantity > 1) {
        item.quantity -= 1;
      } else {
        _cartItems.remove(item);
      }
    });
  }

  double get _totalAmount =>
      _cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  void _checkout() {
    if (_cartItems.isEmpty) return;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Transaksi Selesai'),
        content: Text('Total: Rp ${_totalAmount.toStringAsFixed(0)}'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => _cartItems.clear());
              Navigator.pop(context);
            },
            child: Text('OK'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _cartItems.isEmpty
                ? Center(child: Text('Keranjang kosong'))
                : ListView.builder(
                    itemCount: _cartItems.length,
                    itemBuilder: (_, index) => CartItemTile(
                      cartItem: _cartItems[index],
                      onAdd: () => _increment(_cartItems[index]),
                      onRemove: () => _decrement(_cartItems[index]),
                    ),
                  ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: Rp ${_totalAmount.toStringAsFixed(0)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: _checkout,
                  child: Text('Checkout'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
