// lib/models/order.dart
import 'order_item.dart';
import 'payment_option.dart';

class Order {
  final int id;
  final List<OrderItem> items;
  final double totalAmount;
  final String status; // e.g., "PENDING", "SHIPPED", "DELIVERED"
  final DateTime createdAt;
  final PaymentOption? paymentOption;

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.paymentOption,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e))
          .toList(),
      totalAmount: (json['total'] as num).toDouble(),
      status: json['status'] ?? 'PENDING',
      createdAt: DateTime.parse(json['createdAt']),
      paymentOption: json['paymentOption'] != null
          ? PaymentOption.fromJson(json['paymentOption'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((e) => e.toJson()).toList(),
      'total': totalAmount,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'paymentOption': paymentOption?.toJson(),
    };
  }
}
