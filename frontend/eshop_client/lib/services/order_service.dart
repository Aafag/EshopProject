// lib/services/order_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/order.dart';

class OrderService {
  // Get all orders
  Future<List<Order>> getOrders() async {
    final res = await http.get(Uri.parse(ApiConfig.orders));
    if (res.statusCode != 200) throw Exception('Failed to load orders');
    final List<dynamic> data = json.decode(res.body);
    return data.map((e) => Order.fromJson(e)).toList();
  }

  // Place a new order
  Future<Order> placeOrder(int paymentOptionId) async {
    final res = await http.post(
      Uri.parse(ApiConfig.orders),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'paymentOptionId': paymentOptionId}),
    );
    if (res.statusCode != 200 && res.statusCode != 201) {
      throw Exception('Failed to place order');
    }
    return Order.fromJson(json.decode(res.body));
  }

  // Get single order by ID
  Future<Order> getOrder(int id) async {
    final res = await http.get(Uri.parse('${ApiConfig.orders}/$id'));
    if (res.statusCode != 200) throw Exception('Order not found');
    return Order.fromJson(json.decode(res.body));
  }
}
