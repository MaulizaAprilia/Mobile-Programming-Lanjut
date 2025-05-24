import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import 'add_edit_product_screen.dart';

class ProductsScreen extends StatefulWidget {
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> _products = [
  Product(id: '1', name: 'Kopi Tubruk', price: 10000, stock: 20, category: 'Minuman'),
  Product(id: '2', name: 'Teh Manis', price: 8000, stock: 25, category: 'Minuman'),
];


  List<Product> _filteredProducts = [];

  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredProducts = _products;
  }

  void _filterProducts(String query) {
    setState(() {
      _searchQuery = query;
      _filteredProducts = _products
          .where((prod) => prod.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _deleteProduct(String id) {
    setState(() {
      _products.removeWhere((prod) => prod.id == id);
      _filterProducts(_searchQuery);
    });
  }

  void _navigateToAddProduct() async {
    final newProduct = await Navigator.push<Product>(
      context,
      MaterialPageRoute(builder: (_) => AddEditProductScreen()),
    );

    if (newProduct != null) {
      setState(() {
        _products.add(newProduct);
        _filterProducts(_searchQuery);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Produk'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Tambah Produk',
            onPressed: _navigateToAddProduct,
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari produk...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: _filterProducts,
            ),
          ),
        ),
      ),
      body: _filteredProducts.isEmpty
          ? Center(child: Text('Produk tidak ditemukan'))
          : ListView.builder(
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                final prod = _filteredProducts[index];
                return ProductCard(
                  product: prod,
                  onDelete: () => _deleteProduct(prod.id),
                );
              },
            ),
    );
  }
}
