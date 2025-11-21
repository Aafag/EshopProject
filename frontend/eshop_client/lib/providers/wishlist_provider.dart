import 'package:eshop_client/models/wishlist_item.dart';
import 'package:eshop_client/services/wishlist_service.dart';
import 'package:eshop_client/utils/navigator_key.dart';
import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier{
  final WishlistService _service = WishlistService();

  List<WishlistItem> _wishlistItems = [];
  bool _isLoading = false;
  String? _error;

  List<WishlistItem> get wishlistItems => _wishlistItems;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get itemCount => _wishlistItems.length;

  //get wishtlsit from backend
  Future<void> loadWishlist() async {
    _isLoading = true;
    notifyListeners();

    try{
      _wishlistItems = await _service.getWishlistItems();
      _error = null;
    }catch(e){
      _error = e.toString();
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }


  //add a product to wishlist
  Future<void> addToWishlist(int productId) async {
    try {
      await _service.addToWishlist(productId);
      await loadWishlist(); // refresh
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(content: Text('Added to wishlist')),
      );
    } catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // Remove and refresh
  Future<void> removeFromWishlist(int id) async {
    try {
      await _service.removeFromWishlist(id);
      _wishlistItems.removeWhere((item) => item.id == id);
      notifyListeners();
    } catch (e) {
      // Even if delete fails, optimistically remove from UI
      _wishlistItems.removeWhere((item) => item.id == id);
      notifyListeners();
    }
  }
}