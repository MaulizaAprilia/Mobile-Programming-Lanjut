import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartItemTile extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  CartItemTile({
    required this.cartItem,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(cartItem.product.name),
      subtitle: Text('Rp ${cartItem.totalPrice.toStringAsFixed(0)}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: onRemove, icon: Icon(Icons.remove_circle)),
          Text('${cartItem.quantity}'),
          IconButton(onPressed: onAdd, icon: Icon(Icons.add_circle)),
        ],
      ),
    );
  }
}
