// lib/models/product.dart
class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String imageName; // ✅ local asset filename
  final String? categoryName;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.imageName,
    this.categoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final category = json['category'] as Map<String, dynamic>?;
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] ?? 0,
      imageName: json['imageName'] ?? '',
      categoryName: category?['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'imageName': imageName,
      if (categoryName != null) 'category': {'name': categoryName},
    };
  }
}
