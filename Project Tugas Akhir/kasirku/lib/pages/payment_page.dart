import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'package:intl/intl.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _bayarController = TextEditingController();
  String _metode = 'Tunai';
  bool _cetakStruk = false;
  bool _konfirmasi = false;

  final formatRupiah = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  void _payNow(CartProvider cart) {
    final bayar = double.tryParse(_bayarController.text) ?? 0;
    final total = cart.totalAmount;

    if (bayar < total) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Jumlah bayar kurang dari total belanja!'), backgroundColor: Colors.red),
      );
      return;
    }

    if (!_konfirmasi) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Harap konfirmasi sebelum membayar.'), backgroundColor: Colors.red),
      );
      return;
    }

    String ringkasan = '''
Total Belanja : ${formatRupiah.format(total)}
Jumlah Bayar  : ${formatRupiah.format(bayar)}
Metode        : $_metode
Cetak Struk   : ${_cetakStruk ? 'Ya' : 'Tidak'}
Kembalian     : ${formatRupiah.format(bayar - total)}
''';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Konfirmasi Pembayaran'),
        content: Text(ringkasan),
        actions: [
          TextButton(child: Text('Batal'), onPressed: () => Navigator.pop(context)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF370505),
              foregroundColor: Colors.white,
            ),
            child: Text('Bayar'),
            onPressed: () {
              Navigator.pop(context);
              cart.clear();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pembayaran berhasil!')));
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran'),
        backgroundColor: Color(0xFF370505),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Belanja:', style: TextStyle(fontSize: 16)),
                Text(
                  formatRupiah.format(cart.totalAmount),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF370505)),
                ),
                SizedBox(height: 16),

                Text('Jumlah Bayar:', style: TextStyle(fontSize: 16)),
                TextField(
                  controller: _bayarController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Masukkan jumlah uang',
                  ),
                ),
                SizedBox(height: 16),

                Text('Metode Pembayaran:'),
                DropdownButton<String>(
                  value: _metode,
                  isExpanded: true,
                  items: ['Tunai', 'QRIS', 'Transfer'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _metode = val!),
                ),

                SwitchListTile(
                  title: Text('Cetak Struk?'),
                  value: _cetakStruk,
                  activeColor: Color(0xFF370505),
                  onChanged: (val) => setState(() => _cetakStruk = val),
                ),

                CheckboxListTile(
                  title: Text('Saya sudah memeriksa transaksi ini.'),
                  value: _konfirmasi,
                  activeColor: Color(0xFF370505),
                  onChanged: (val) => setState(() => _konfirmasi = val!),
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
                    icon: Icon(Icons.payment),
                    label: Text('Bayar Sekarang'),
                    onPressed: () => _payNow(cart),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
