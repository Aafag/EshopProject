import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart'; // make sure you have this
import '../services/cart_service.dart';

class CartProvider extends ChangeNotifier {
  final CartService _service = CartService();

  List<CartItem> _items = [];
  bool _loading = false;
  String? _error;

  List<CartItem> get items => _items;
  bool get loading => _loading;
  String? get error => _error;

  int get itemCount => _items.length;

  double get totalAmount =>
      _items.fold(0, (sum, item) => sum + item.lineTotal);

  //get cart from backend
  Future<void> loadCart() async {
    _loading = true;
    notifyListeners();
    try {
      _items = await _service.getCartItems();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Add product to cart (UI calls with Product object)
  Future<void> addToCart(Product product, {int quantity = 1}) async {
    try {
      await _service.addToCart(product.id, quantity);
      await loadCart();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Remove item from cart and refresh
  Future<void> removeFromCart(int cartItemId) async {
    try {
      await _service.removeFromCart(cartItemId);
      _items.removeWhere((item) => item.id == cartItemId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Remove all and refresh
  Future<void> clearCart() async {
    try {
      await _service.clearCart();
      _items.clear();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
