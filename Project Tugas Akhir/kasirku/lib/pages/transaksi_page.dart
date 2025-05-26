import 'package:flutter/material.dart';

class TransaksiPage extends StatefulWidget {
  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  final TextEditingController _jumlahController = TextEditingController();
  String _metode = 'Tunai';
  bool _cetakStruk = false;
  bool _konfirmasi = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transaksi")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Jumlah Bayar:'),
            TextField(
              controller: _jumlahController,
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
            SwitchListTile(
              title: Text('Cetak Struk?'),
              value: _cetakStruk,
              onChanged: (val) {
                setState(() {
                  _cetakStruk = val;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Saya sudah memeriksa transaksi ini.'),
              value: _konfirmasi,
              onChanged: (val) {
                setState(() {
                  _konfirmasi = val!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.save),
              label: Text('Simpan Transaksi'),
              onPressed: () {
                if (_konfirmasi) {
                  final snackBar = SnackBar(
                    content: Text('Transaksi disimpan: Rp${_jumlahController.text}, Metode: $_metode'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  final snackBar = SnackBar(
                    content: Text('Harap konfirmasi transaksi sebelum menyimpan.'),
                    backgroundColor: const Color.fromARGB(255, 55, 5, 5),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
