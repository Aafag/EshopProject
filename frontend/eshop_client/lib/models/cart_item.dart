// lib/models/cart_item.dart
import 'product.dart';

class CartItem {
  final int id;
  final Product product;
  final int quantity;
  final double unitPrice;
  final double lineTotal;

  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
    required this.unitPrice,
    required this.lineTotal,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      product: Product.fromJson(json['product']),
      quantity: json['quantity'] ?? 1,
      unitPrice: (json['unitPrice'] as num).toDouble(),
      lineTotal: (json['lineTotal'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'quantity': quantity,
      'unitPrice': unitPrice,
      'lineTotal': lineTotal,
    };
  }
}
