import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/product.dart';

class AddEditProductScreen extends StatefulWidget {
  final Product? product;

  AddEditProductScreen({this.product});

  @override
  _AddEditProductScreenState createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late double _price;
  late int _stock;
  late String _category;

  final List<String> _categories = ['Minuman', 'Makanan', 'Snack', 'Lainnya'];

  @override
  void initState() {
    super.initState();
    _name = widget.product?.name ?? '';
    _price = widget.product?.price ?? 0;
    _stock = widget.product?.stock ?? 0;
    _category = widget.product?.category ?? _categories[0];
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newProduct = Product(
        id: widget.product?.id ?? const Uuid().v4(),
        name: _name,
        price: _price,
        stock: _stock,
        category: _category,
      );
      Navigator.pop(context, newProduct);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'Tambah Produk' : 'Edit Produk'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Nama Produk'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama produk wajib diisi';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!.trim(),
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _price == 0 ? '' : _price.toString(),
                decoration: InputDecoration(labelText: 'Harga (Rp)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Harga wajib diisi';
                  }
                  final price = double.tryParse(value);
                  if (price == null || price <= 0) {
                    return 'Harga harus berupa angka positif';
                  }
                  return null;
                },
                onSaved: (value) => _price = double.parse(value!),
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _stock.toString(),
                decoration: InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  final val = int.tryParse(value!);
                  if (val == null || val < 0) {
                    return 'Stok harus angka positif';
                  }
                  return null;
                },
                onSaved: (value) => _stock = int.parse(value!),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: InputDecoration(labelText: 'Kategori Produk'),
                items: _categories
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _category = value!),
                onSaved: (value) => _category = value!,
              ),
              SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _saveProduct,
                icon: Icon(Icons.save),
                label: Text('Simpan Produk'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
