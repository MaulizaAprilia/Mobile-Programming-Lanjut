import 'package:flutter/material.dart';

import '../services/cart_service.dart';
import '../widgets/cart_item_widget.dart';
import '../dialogs/confirmation_dialog.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartService _cartService = CartService();

  void _clearCart() async {
    final confirmed = await showConfirmationDialog(context, 'Kosongkan keranjang?');
    if (confirmed) {
      setState(() {
        _cartService.clearCart();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = _cartService.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
        actions: [
          if (items.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: _clearCart,
              tooltip: 'Kosongkan Keranjang',
            ),
        ],
      ),
      body: items.isEmpty
          ? const Center(child: Text('Keranjang kosong'))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final cartItem = items[index];
                return CartItemWidget(cartItem: cartItem);
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Rp ${_cartService.totalPrice.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
