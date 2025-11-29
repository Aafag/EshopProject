import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class CatalogProvider extends ChangeNotifier {
  final _service = ProductService();
  List<Product> products = [];
  List<Product> _filteredProducts = []; // 🔹 internal list
  bool loading = false;
  String? error;

  // Track selected category filter
  String _selectedCategory = 'All';
  String get selectedCategory => _selectedCategory;

  // Track search query
  String _searchQuery = '';

  // Expose filtered products to UI
  List<Product> get filteredProducts => _filteredProducts;

  // Called when user selects a category from dropdown
  void setCategoryFilter(String category) {
    _selectedCategory = category;
    _applyFilters();
    notifyListeners();
  }

  // Called when user types in search bar
  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }

  // Apply both category + search filters
  void _applyFilters() {
    _filteredProducts = products.where((product) {
      final matchesCategory =
          _selectedCategory == 'All' || product.categoryName == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          (product.name?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  // Load products from backend
  Future<void> loadProducts() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      products = await _service.fetchProducts();
      _applyFilters(); // 🔹 apply filters after loading
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
