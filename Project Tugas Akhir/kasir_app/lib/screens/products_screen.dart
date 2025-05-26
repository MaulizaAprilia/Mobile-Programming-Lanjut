import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/product_service.dart';
import '../dialogs/input_product_dialog.dart';
import '../dialogs/confirmation_dialog.dart';
import '../widgets/product_card.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductService _productService = ProductService();
  List<Product> _products = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() => _loading = true);
    final products = await _productService.fetchProducts();
    setState(() {
      _products = products;
      _loading = false;
    });
  }

  Future<void> _addOrEditProduct({Product? product}) async {
    final result = await showDialog<Product?>(
      context: context,
      builder: (_) => InputProductDialog(product: product),
    );

    if (result != null) {
      if (product == null) {
        await _productService.addProduct(result);
      } else {
        await _productService.updateProduct(result);
      }
      await _loadProducts();
    }
  }

  Future<void> _deleteProduct(Product product) async {
    final confirmed = await showConfirmationDialog(
        context, 'Yakin ingin menghapus produk "${product.name}"?');
    if (confirmed) {
      await _productService.deleteProduct(product.id);
      await _loadProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _products.isEmpty
              ? const Center(child: Text('Belum ada produk'))
              : ListView.builder(
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final product = _products[index];
                    return Dismissible(
                      key: ValueKey(product.id),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (_) async {
                        return await showConfirmationDialog(
                            context, 'Hapus produk "${product.name}"?');
                      },
                      onDismissed: (_) => _deleteProduct(product),
                      child: ProductCard(
                        product: product,
                        onEdit: () => _addOrEditProduct(product: product),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditProduct(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
