// lib/services/cart_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/cart_item.dart';

class CartService {
  // Get all cart items
  Future<List<CartItem>> getCartItems() async {
    final res = await http.get(Uri.parse(ApiConfig.cart));
    if (res.statusCode != 200) throw Exception('Failed to load cart items');
    final List<dynamic> data = json.decode(res.body);
    return data.map((e) => CartItem.fromJson(e)).toList();
  }

  // Add product to cart
  Future<CartItem> addToCart(int productId, int quantity) async {
    final res = await http.post(
      Uri.parse('${ApiConfig.cart}/$productId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'quantity': quantity}),
    );
    if (res.statusCode != 200 && res.statusCode != 201) {
      throw Exception('Failed to add to cart');
    }
    return CartItem.fromJson(json.decode(res.body));
  }

  // Remove item from cart
  Future<void> removeFromCart(int cartItemId) async {
    final res = await http.delete(Uri.parse('${ApiConfig.cart}/$cartItemId'));
    if (res.statusCode != 200 && res.statusCode != 204) {
      throw Exception('Failed to remove cart item');
    }
  }

  // Clear cart
  Future<void> clearCart() async {
    final res = await http.delete(Uri.parse('${ApiConfig.cart}/clear'));
    if (res.statusCode != 200 && res.statusCode != 204) {
      throw Exception('Failed to clear cart');
    }
  }
}
