import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'payment_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
        backgroundColor: Color(0xFF370505),
      ),
      body: cart.itemCount == 0
          ? Center(
              child: Text(
                'Keranjang kosong',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.itemCount,
                    itemBuilder: (ctx, i) {
                      var cartItem = cart.items.values.toList()[i];
                      return ListTile(
                        leading: Image.asset(
                          cartItem.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(cartItem.title),
                        subtitle: Text('Jumlah: ${cartItem.quantity}'),
                        trailing: Text('Rp ${(cartItem.price * cartItem.quantity).toStringAsFixed(0)}'),
                        // Tombol hapus
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('Hapus Item'),
                              content: Text('Yakin ingin menghapus ${cartItem.title} dari keranjang?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Batal'),
                                ),
                               
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Rp ${cart.totalAmount.toStringAsFixed(0)}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: cart.itemCount == 0
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => PaymentPage()),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF370505),
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 48),
                    ),
                    child:  Text('Lanjut ke Pembayaran'),
                  ),
                )
              ],
            ),
    );
  }
}
