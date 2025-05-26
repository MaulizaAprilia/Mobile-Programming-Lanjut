import 'package:flutter/material.dart';

/// Widget untuk menampilkan nama produk dengan styling standar
class ProductName extends StatelessWidget {
  final String nama;

  const ProductName({Key? key, required this.nama}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      nama,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

/// Widget untuk menampilkan harga produk dengan format rupiah
class ProductPrice extends StatelessWidget {
  final int harga;

  const ProductPrice({Key? key, required this.harga}) : super(key: key);

  String _formatRupiah(int amount) {
    // format angka jadi Rp 10.000 dst (simple)
    return 'Rp ${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatRupiah(harga),
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: const Color.fromARGB(255, 55, 5, 5),
            fontWeight: FontWeight.w600,
          ),
    );
  }
}

/// Widget menampilkan jumlah quantity produk dan tombol plus-minus
class QuantitySelector extends StatefulWidget {
  final int initialQuantity;
  final ValueChanged<int>? onQuantityChanged;

  const QuantitySelector({
    Key? key,
    this.initialQuantity = 1,
    this.onQuantityChanged,
  }) : super(key: key);

  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
  }

  void _increment() {
    setState(() {
      _quantity++;
      widget.onQuantityChanged?.call(_quantity);
    });
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        widget.onQuantityChanged?.call(_quantity);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.remove_circle_outline),
          color: _quantity > 1 ? const Color.fromARGB(255, 55, 5, 5) : Colors.grey,
          onPressed: _decrement,
          tooltip: 'Kurangi jumlah',
        ),
        Text(
          '$_quantity',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        IconButton(
          icon: Icon(Icons.add_circle_outline),
          color:const Color.fromARGB(255, 55, 5, 5),
          onPressed: _increment,
          tooltip: 'Tambah jumlah',
        ),
      ],
    );
  }
}

/// Widget menampilkan total harga produk (harga * quantity)
class TotalPrice extends StatelessWidget {
  final int harga;
  final int quantity;

  const TotalPrice({Key? key, required this.harga, required this.quantity})
      : super(key: key);

  String _formatRupiah(int amount) {
    return 'Rp ${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }

  @override
  Widget build(BuildContext context) {
    final total = harga * quantity;
    return Text(
      _formatRupiah(total),
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color:const Color.fromARGB(255, 55, 5, 5)
          ),
    );
  }
}
