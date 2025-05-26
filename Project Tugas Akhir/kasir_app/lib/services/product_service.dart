import '../models/product.dart';

class ProductService {
  // Simulasi data produk dari database lokal / API
  final List<Product> _products = [
    Product(id: 1, name: 'Kopi Susu', price: 10000, imageUrl: 'https://via.placeholder.com/150'),
    Product(id: 2, name: 'Caramel Machiato', price: 20000, imageUrl: 'https://via.placeholder.com/150'),
    Product(id: 3, name: 'Kentang Goreng', price: 15000, imageUrl: 'https://via.placeholder.com/150'),
  ];

  Future<List<Product>> fetchProducts() async {
    // Simulasi delay seperti request ke database / API
    await Future.delayed(const Duration(milliseconds: 500));
    return _products;
  }

  Future<void> addProduct(Product product) async {
    _products.add(product);
  }

  Future<void> updateProduct(Product product) async {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _products[index] = product;
    }
  }

  Future<void> deleteProduct(int id) async {
    _products.removeWhere((p) => p.id == id);
  }
}
