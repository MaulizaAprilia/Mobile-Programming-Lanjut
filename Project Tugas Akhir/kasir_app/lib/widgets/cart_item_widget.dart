import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback? onRemove;

  const CartItemWidget({required this.cartItem, this.onRemove, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(cartItem.product.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
      title: Text(cartItem.product.name),
      subtitle: Text('Jumlah: ${cartItem.quantity} - Total: Rp ${cartItem.totalPrice.toStringAsFixed(0)}'),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onRemove,
      ),
    );
  }
}
