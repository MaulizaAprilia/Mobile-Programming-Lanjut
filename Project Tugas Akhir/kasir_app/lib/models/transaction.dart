import 'cart_item.dart';

class Transaction {
  final int id;
  final List<CartItem> items;
  final DateTime date;

  Transaction({
    required this.id,
    required this.items,
    required this.date,
  });

  double get totalAmount =>
      items.fold(0, (sum, item) => sum + item.totalPrice);
}
