import '../models/cart_item.dart';
import '../models/product.dart';

class CartService {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => List.unmodifiable(_cartItems);

  void addToCart(Product product) {
    final index = _cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(CartItem(product: product));
    }
  }

  void removeFromCart(Product product) {
    _cartItems.removeWhere((item) => item.product.id == product.id);
  }

  void clearCart() {
    _cartItems.clear();
  }

  double get totalPrice =>
      _cartItems.fold(0, (total, item) => total + item.totalPrice);
}
