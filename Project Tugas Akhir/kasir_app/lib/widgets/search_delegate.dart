import 'package:flutter/material.dart';
import '../models/product.dart';


class ProductSearchDelegate extends SearchDelegate<Product> {
  final List<Product> products;

  ProductSearchDelegate(this.products);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, products.first));
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = products.where((p) => p.name.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(results[index].name),
        subtitle: Text('Rp ${results[index].price.toStringAsFixed(0)}'),
        leading: Image.network(results[index].imageUrl, width: 40, height: 40),
        onTap: () => close(context, results[index]),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = products.where((p) => p.name.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(suggestions[index].name),
        onTap: () {
          query = suggestions[index].name;
          showResults(context);
        },
      ),
    );
  }
}
