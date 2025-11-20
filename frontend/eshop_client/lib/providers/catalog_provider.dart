import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class CatalogProvider extends ChangeNotifier {
  final _service = ProductService();
  List<Product> products = [];
  bool loading = false;
  String? error;

  Future<void> loadProducts() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      products = await _service.fetchProducts();
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
