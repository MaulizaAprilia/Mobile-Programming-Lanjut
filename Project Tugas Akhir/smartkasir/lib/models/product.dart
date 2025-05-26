class Product {
  final int? id;
  final String name;
  final int price;    // Ganti jadi int supaya bisa kalkulasi dengan mudah
  final int stock;    // Ganti juga jadi int
  final String category;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.category,
  });

  // Convert object ke Map untuk simpan ke database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'stock': stock,
      'category': category,
    };
  }

  // Membuat object Product dari Map hasil query database
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int?,
      name: map['name'] as String,
      price: map['price'] as int,
      stock: map['stock'] as int,
      category: map['category'] as String,
    );
  }
}
