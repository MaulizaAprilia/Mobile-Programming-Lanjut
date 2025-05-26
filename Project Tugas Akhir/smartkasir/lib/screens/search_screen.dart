import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _dummyProducts = [
    'Kopi Hitam',
    'Teh Manis',
    'Roti Bakar',
    'Nasi Goreng',
    'Air Mineral',
    'Laptop',
    'Mouse Wireless',
    'Minyak Goreng',
  ];

  List<String> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _filteredProducts = _dummyProducts;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final keyword = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _dummyProducts
          .where((product) => product.toLowerCase().contains(keyword))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, _) {
        return [
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: true,
            title: const Text('Pencarian Produk'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _buildSearchField(),
              ),
            ),
          ),
        ];
      },
      body: _buildSearchResults(),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Cari produk...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.separated(
      itemCount: _filteredProducts.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final product = _filteredProducts[index];
        return ListTile(
          leading: const Icon(Icons.shopping_bag),
          title: Text(product),
          subtitle: const Text('Kategori: Contoh'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Detail produk "$product"')),
            );
          },
        );
      },
    );
  }
}
