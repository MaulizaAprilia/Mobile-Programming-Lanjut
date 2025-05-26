import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransaksiPage extends StatefulWidget {
  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  final TextEditingController _jumlahController = TextEditingController();
  String _metode = 'Tunai';
  bool _cetakStruk = false;
  bool _konfirmasi = false;

  // Simulasi produk dalam keranjang
  final List<Map<String, dynamic>> _keranjang = [
    {'nama': 'Shampoo', 'qty': 2, 'harga': 15000},
    {'nama': 'Pewangi Ruangan', 'qty': 1, 'harga': 22000},
  ];

  double get _totalBayar {
    return _keranjang.fold(0, (sum, item) => sum + (item['harga'] * item['qty']));
  }

  void _simpanTransaksi() {
    double? jumlahBayar = double.tryParse(_jumlahController.text);

    if (jumlahBayar == null || jumlahBayar < _totalBayar) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Jumlah bayar tidak valid atau kurang dari total.'),
          backgroundColor: Color(0xFF370505),
        ),
      );
      return;
    }

    if (!_konfirmasi) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Harap konfirmasi transaksi sebelum menyimpan.'),
          backgroundColor: Color(0xFF370505),
        ),
      );
      return;
    }

    double kembalian = jumlahBayar - _totalBayar;
    String waktu = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());
    String idTransaksi = 'TRX${DateTime.now().millisecondsSinceEpoch}';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Konfirmasi Transaksi'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID Transaksi: $idTransaksi'),
            Text('Waktu: $waktu'),
            Divider(),
            ..._keranjang.map((item) => Text('${item['qty']}x ${item['nama']}')),
            Divider(),
            Text('Total Bayar : Rp${_totalBayar.toStringAsFixed(0)}'),
            Text('Jumlah Diterima : Rp${jumlahBayar.toStringAsFixed(0)}'),
            Text('Kembalian : Rp${kembalian.toStringAsFixed(0)}'),
            Text('Metode : $_metode'),
            Text('Cetak Struk : ${_cetakStruk ? 'Ya' : 'Tidak'}'),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Batal'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF370505),
              foregroundColor: Colors.white,
            ),
            child: Text('Simpan'),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Transaksi berhasil disimpan.'),
                ),
              );
              _jumlahController.clear();
              setState(() {
                _metode = 'Tunai';
                _cetakStruk = false;
                _konfirmasi = false;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaksi"),
        backgroundColor: Color(0xFF370505),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Daftar Produk:', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF370505))),
                SizedBox(height: 10),
                ..._keranjang.map((item) => Text('${item['qty']}x ${item['nama']} - Rp${item['harga']}')),
                Divider(height: 30),

                Text('Total Bayar: Rp${_totalBayar.toStringAsFixed(0)}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                SizedBox(height: 20),
                Text('Jumlah Uang Diterima:', style: TextStyle(color: Color(0xFF370505))),
                TextField(
                  controller: _jumlahController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Contoh: 50000',
                  ),
                ),
                SizedBox(height: 20),

                Text('Metode Pembayaran:', style: TextStyle(color: Color(0xFF370505))),
                DropdownButton<String>(
                  value: _metode,
                  isExpanded: true,
                  items: ['Tunai', 'QRIS', 'Transfer'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _metode = val!;
                    });
                  },
                ),
                Divider(height: 30),

                SwitchListTile(
                  title: Text('Cetak Struk?', style: TextStyle(color: Color(0xFF370505))),
                  value: _cetakStruk,
                  activeColor: Color(0xFF370505),
                  onChanged: (val) {
                    setState(() {
                      _cetakStruk = val;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('Saya sudah memeriksa transaksi ini.', style: TextStyle(color: Color(0xFF370505))),
                  value: _konfirmasi,
                  activeColor: Color(0xFF370505),
                  checkColor: Colors.white,
                  onChanged: (val) {
                    setState(() {
                      _konfirmasi = val!;
                    });
                  },
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF370505),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    icon: Icon(Icons.save, color: Colors.white,),
                    label: Text('Simpan Transaksi'),
                    onPressed: _simpanTransaksi,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
