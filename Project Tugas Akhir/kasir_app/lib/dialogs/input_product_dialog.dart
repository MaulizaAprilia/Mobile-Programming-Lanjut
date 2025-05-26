import 'package:flutter/material.dart';
import '../models/product.dart';

class InputProductDialog extends StatefulWidget {
  final Product? product; // Kalau edit, data produk diisi, kalau tambah null

  const InputProductDialog({this.product, Key? key}) : super(key: key);

  @override
  _InputProductDialogState createState() => _InputProductDialogState();
}

class _InputProductDialogState extends State<InputProductDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _imageUrlController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _priceController = TextEditingController(text: widget.product?.price.toString() ?? '');
    _imageUrlController = TextEditingController(text: widget.product?.imageUrl ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.product == null ? 'Tambah Produk' : 'Edit Produk'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Produk'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Nama produk harus diisi' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Harga harus diisi';
                  final n = num.tryParse(value);
                  if (n == null || n <= 0) return 'Harga tidak valid';
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'URL Gambar'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'URL gambar harus diisi' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Batal'),
          onPressed: () => Navigator.of(context).pop(null),
        ),
        ElevatedButton(
          child: const Text('Simpan'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final product = Product(
                id: widget.product?.id ?? DateTime.now().millisecondsSinceEpoch,
                name: _nameController.text.trim(),
                price: double.parse(_priceController.text),
                imageUrl: _imageUrlController.text.trim(),
              );
              Navigator.of(context).pop(product);
            }
          },
        ),
      ],
    );
  }
}
