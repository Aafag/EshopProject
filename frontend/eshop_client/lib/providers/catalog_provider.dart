import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class CatalogProvider extends ChangeNotifier {
  final _service = ProductService();
  List<Product> products = [];
  bool loading = false;
  String? error;

// NEW: Track selected category filter
  String _selectedCategory = 'All';  // ← NEW: Default = show all products
  String get selectedCategory => _selectedCategory;  // ← NEW: Getter


  // NEW: Return filtered products based on selected category
  List<Product> get filteredProducts {  // ← NEW: This is what UI will use
    if (_selectedCategory == 'All') {
      return products;
    }
    return products
        .where((product) => product.categoryName == _selectedCategory)
        .toList();
  }  // ← NEW: End of getter

// NEW: Called when user selects a category from dropdown
  void setCategoryFilter(String category) {  // ← NEW: Method
    _selectedCategory = category;
    notifyListeners();  // ← NEW: Instantly updates the product grid
  }  // ← NEW: End of method

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

  void filterProducts(String query) {}
}
