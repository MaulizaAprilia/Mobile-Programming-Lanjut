import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/cart_page.dart'; // Tambahkan ini di bagian import paling atas
import '../widgets/produk_card.dart';
import '../providers/cart_provider.dart';
import '../models/product.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({Key? key}) : super(key: key);

  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  List<Map<String, dynamic>> _produkList = [
    {
      'nama': 'Sabun Mandi',
      'harga': 10000,
      'gambar': 'assets/sabun_mandi.jpg',
      'deskripsi': 'Sabun mandi wangi dan lembut di kulit.'
    },
    {
      'nama': 'Shampoo',
      'harga': 15000,
      'gambar': 'assets/shampoo.jpg',
      'deskripsi': 'Shampoo menyegarkan dan anti ketombe.'
    },
    {
      'nama': 'Sikat Gigi',
      'harga': 5000,
      'gambar': 'assets/sikat_gigi.jpg',
      'deskripsi': 'Sikat gigi dengan bulu halus dan nyaman.'
    },
    {
      'nama': 'Pasta Gigi',
      'harga': 12000,
      'gambar': 'assets/pasta_gigi.jpg',
      'deskripsi': 'Pasta gigi pemutih dan menyegarkan napas.'
    },
    {
      'nama': 'Handuk Mandi',
      'harga': 35000,
      'gambar': 'assets/handuk_mandi.jpg',
      'deskripsi': 'Handuk mandi lembut dan cepat kering.'
    },
    {
      'nama': 'Deodorant',
      'harga': 20000,
      'gambar': 'assets/deodorant.jpg',
      'deskripsi': 'Deodorant anti bau badan, tahan lama.'
    },
    {
      'nama': 'Sabun Cuci Piring',
      'harga': 15000,
      'gambar': 'assets/sabun_cuci_piring.jpg',
      'deskripsi': 'Sabun cuci piring yang efektif membersihkan lemak.'
    },
    {
      'nama': 'Pembersih Lantai',
      'harga': 18000,
      'gambar': 'assets/pembersih_lantai.jpg',
      'deskripsi': 'Pembersih lantai wangi dan membersihkan kotoran.'
    },
    {
      'nama': 'Pewangi Ruangan',
      'harga': 22000,
      'gambar': 'assets/pewangi_ruangan.jpg',
      'deskripsi': 'Pewangi ruangan dengan aroma segar dan tahan lama.'
    },
    {
      'nama': 'Sikat WC',
      'harga': 12000,
      'gambar': 'assets/sikat_wc.jpg',
      'deskripsi': 'Sikat WC kuat dengan gagang ergonomis.'
    },
    {
      'nama': 'Sarung Tangan Karet',
      'harga': 8000,
      'gambar': 'assets/sarung_tangan_karet.jpg',
      'deskripsi': 'Sarung tangan karet pelindung tangan saat membersihkan.'
    },
    {
      'nama': 'Sabun Cuci Tangan',
      'harga': 9000,
      'gambar': 'assets/sabun_cuci_tangan.jpg',
      'deskripsi': 'Sabun cuci tangan antibakteri, lembut di kulit.'
    },
    {
      'nama': 'Kapas Mandi',
      'harga': 7000,
      'gambar': 'assets/kapas_mandi.jpg',
      'deskripsi': 'Kapas mandi lembut, cocok untuk kulit sensitif.'
    },
  ];

  List<Map<String, dynamic>> _filteredProduk = [];
  String _searchQuery = '';

  final _formKey = GlobalKey<FormState>();
  String _inputNama = '';
  String _inputHarga = '';
  String _inputGambar = '';
  String _inputDeskripsi = '';

  int? _editIndex;

  @override
  void initState() {
    super.initState();
    _filteredProduk = _produkList;
  }

  void _filterProduk(String query) {
    final filtered = _produkList
        .where((p) => p['nama'].toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _searchQuery = query;
      _filteredProduk = filtered;
    });
  }

  void _showFormDialog({bool isEdit = false, int? index}) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    if (isEdit && index != null) {
      final produk = _produkList[index];
      _inputNama = produk['nama'];
      _inputHarga = produk['harga'].toString();
      _inputGambar = produk['gambar'];
      _inputDeskripsi = produk['deskripsi'] ?? '';
      _editIndex = index;
    } else {
      _inputNama = '';
      _inputHarga = '';
      _inputGambar = '';
      _inputDeskripsi = '';
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
              children: [
                TextFormField(
                  initialValue: _inputNama,
                  decoration: const InputDecoration(labelText: 'Nama Produk'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Wajib diisi' : null,
                  onSaved: (v) => _inputNama = v!.trim(),
                ),
                TextFormField(
                  initialValue: _inputHarga,
                  decoration: const InputDecoration(labelText: 'Harga Produk'),
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Wajib diisi';
                    if (int.tryParse(v) == null) return 'Harus angka';
                    return null;
                  },
                  onSaved: (v) => _inputHarga = v!.trim(),
                ),
                TextFormField(
                  initialValue: _inputGambar,
                  decoration:
                      const InputDecoration(labelText: 'File Gambar (di assets)'),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Wajib diisi' : null,
                  onSaved: (v) => _inputGambar = v!.trim(),
                ),
                TextFormField(
                  initialValue: _inputDeskripsi,
                  decoration: const InputDecoration(labelText: 'Deskripsi Produk'),
                  maxLines: 3,
                  onSaved: (v) => _inputDeskripsi = v!.trim(),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Chip(
                label: Text(
                  '${_produkList.length} Produk',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.black54,
              ),
            ),
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartPage()),
                  );
                },
              ),
              if (cartProvider.itemCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF370505),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      '${cartProvider.itemCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
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
        'deskripsi': _inputDeskripsi,
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
        'deskripsi': _inputDeskripsi,
      };
      _filterProduk(_searchQuery);
    });
  }

  void _deleteProduk(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Yakin ingin menghapus produk ini?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _produkList.removeAt(index);
                _filterProduk(_searchQuery);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Produk dihapus!'),
                  backgroundColor: Color(0xFF370505),
                ),
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context); // listen: true agar rebuild saat cart berubah

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Produk', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF370505),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Chip(
                label: Text(
                  '${_produkList.length} Produk',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.black54,
              ),
            ),
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartPage()),
                  );
                },
              ),
              if (cartProvider.itemCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF370505),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      '${cartProvider.itemCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Cari Produk',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterProduk,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _filteredProduk.isEmpty
                  ? const Center(child: Text('Produk tidak ditemukan.'))
                  : ListView.builder(
                      itemCount: _filteredProduk.length,
                      itemBuilder: (context, index) {
                        final produk = _filteredProduk[index];
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      produk['gambar'],
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          width: 60,
                                          height: 60,
                                          color: Colors.grey[300],
                                          child: const Icon(Icons.broken_image, size: 30),
                                        );
                                      },
                                    ),
                                  ),
                                  title: Text(
                                    produk['nama'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Rp ${produk['harga'].toString()}',
                                    style: const TextStyle(color: Color.fromARGB(255, 117, 11, 11)),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.add_shopping_cart, color: Color(0xFF370505)),
                                    tooltip: 'Tambah ke Keranjang',
                                    onPressed: () {
                                      final product = Product(
                                        name: produk['nama'],
                                        price: produk['harga'],
                                        imageUrl: produk['gambar'],
                                      );

                                      cartProvider.addItem(product);

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('${produk['nama']} ditambahkan ke keranjang!'),
                                          duration: const Duration(seconds: 2),
                                          backgroundColor: const Color(0xFF370505),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Color.fromARGB(255, 0, 114, 207)),
                                      onPressed: () {
                                        final realIndex = _produkList.indexOf(produk);
                                        _showFormDialog(isEdit: true, index: realIndex);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Color.fromARGB(255, 117, 11, 11)),
                                      onPressed: () {
                                        final realIndex = _produkList.indexOf(produk);
                                        _deleteProduk(realIndex);
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),

            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF370505),
        onPressed: () {
          _showFormDialog();
        },
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}
