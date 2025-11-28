// lib/providers/order_provider.dart
import 'package:eshop_client/providers/cart_provider.dart';
import 'package:eshop_client/utils/navigator_key.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../models/order.dart';
import '../services/order_service.dart';

class OrderProvider extends ChangeNotifier {
  final OrderService _service = OrderService();

  List<Order> _orders = [];
  bool _loading = false;
  String? _error;

  List<Order> get orders => _orders;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> loadOrders() async {
    _loading = true;
    notifyListeners();
    try {
      _orders = await _service.getOrders();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<Order?> placeOrder(int paymentOptionId) async {
    try {
      print("Placing order with payment option ID: $paymentOptionId");
      final order = await _service.placeOrder(paymentOptionId);
      print("Order created successfully! ID: ${order.id}");
      _orders.add(order);
      notifyListeners();
      return order;
    } catch (e,stackTrace) {
      print("PLACE ORDER ERROR: $e");
      print(stackTrace);
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }
}
