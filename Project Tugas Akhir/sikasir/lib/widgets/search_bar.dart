import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchBar({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Cari...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}