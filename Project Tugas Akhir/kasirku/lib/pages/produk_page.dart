import 'package:flutter/material.dart';
import '../widgets/produk_card.dart';

class ProdukPage extends StatefulWidget {
  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  List<Map<String, dynamic>> _produkList = [
    {'nama': 'Sabun Mandi', 'harga': 10000, 'gambar': 'assets/sabun.jpg'},
    {'nama': 'Shampoo', 'harga': 25000, 'gambar': 'assets/shampoo.jpg'},
    {'nama': 'Sikat Gigi', 'harga': 5000, 'gambar': 'assets/sikat_gigi.jpg'},
    {'nama': 'Pasta Gigi', 'harga': 12000, 'gambar': 'assets/pasta_gigi.jpg'},
  ];

  List<Map<String, dynamic>> _filteredProduk = [];
  String _searchQuery = '';

  final _formKey = GlobalKey<FormState>();
  String _inputNama = '';
  String _inputHarga = '';
  String _inputGambar = '';
  
  int? _editIndex;

  @override
  void initState() {
    super.initState();
    _filteredProduk = _produkList;
  }

  void _filterProduk(String query) {
    List<Map<String, dynamic>> filtered = _produkList
        .where((produk) =>
            produk['nama'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      _searchQuery = query;
      _filteredProduk = filtered;
    });
  }

  void _showFormDialog({bool isEdit = false, int? index}) {
    if (isEdit && index != null) {
      final produk = _produkList[index];
      _inputNama = produk['nama'];
      _inputHarga = produk['harga'].toString();
      _inputGambar = produk['gambar'];
      _editIndex = index;
    } else {
      _inputNama = '';
      _inputHarga = '';
      _inputGambar = '';
      _editIndex = null;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isEdit ? 'Edit Produk' : 'Tambah Produk'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: _inputNama,
                  decoration: InputDecoration(labelText: 'Nama Produk'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama produk wajib diisi';
                    }
                    return null;
                  },
                  onSaved: (value) => _inputNama = value!.trim(),
                ),
                TextFormField(
                  initialValue: _inputHarga,
                  decoration: InputDecoration(labelText: 'Harga Produk'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harga produk wajib diisi';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Harga harus berupa angka';
                    }
                    return null;
                  },
                  onSaved: (value) => _inputHarga = value!.trim(),
                ),
                TextFormField(
                  initialValue: _inputGambar,
                  decoration: InputDecoration(
                      labelText: 'Nama file gambar (assets folder)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama file gambar wajib diisi';
                    }
                    return null;
                  },
                  onSaved: (value) => _inputGambar = value!.trim(),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text('Batal')),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (_editIndex != null) {
                  _updateProduk(_editIndex!);
                } else {
                  _addProduk();
                }
                Navigator.pop(context);
              }
            },
            child: Text(isEdit ? 'Update' : 'Tambah'),
          ),
        ],
      ),
    );
  }

  void _addProduk() {
    setState(() {
      _produkList.add({
        'nama': _inputNama,
        'harga': int.parse(_inputHarga),
        'gambar': _inputGambar,
      });
      _filterProduk(_searchQuery);
    });
  }

  void _updateProduk(int index) {
    setState(() {
      _produkList[index] = {
        'nama': _inputNama,
        'harga': int.parse(_inputHarga),
        'gambar': _inputGambar,
      };
      _filterProduk(_searchQuery);
    });
  }

  void _deleteProduk(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Konfirmasi Hapus'),
        content: Text('Yakin ingin menghapus produk ini?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text('Batal')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _produkList.removeAt(index);
                _filterProduk(_searchQuery);
              });
              Navigator.pop(context);
            },
            child: Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kelola Produk', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF370505), // merah maroon
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari produk...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white70,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: _filterProduk,
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: _filteredProduk.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                final produk = _filteredProduk[index];
                int realIndex = _produkList.indexOf(produk); // untuk edit/delete benar
                return ProdukCard(
                  nama: produk['nama'],
                  harga: produk['harga'],
                  gambar: produk['gambar'],
                  onEdit: () => _showFormDialog(isEdit: true, index: realIndex),
                  onDelete: () => _deleteProduk(realIndex),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF370505),
        child: Icon(Icons.add),
        onPressed: () => _showFormDialog(),
      ),
    );
  }
}
