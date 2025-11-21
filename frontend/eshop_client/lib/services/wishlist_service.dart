import 'dart:convert';

import 'package:eshop_client/models/wishlist_item.dart';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';



class WishlistService{
  //Get all wishlist items
  Future<List<WishlistItem>> getWishlistItems() async {
    final response  = await http.get(Uri.parse(ApiConfig.wishlist));

    if(response.statusCode==200){
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => WishlistItem.fromJson(item)).toList();
    }else{
      throw Exception('Failed to load wishlist items');
    }
  }

  
  //add product to wishlist
  Future<WishlistItem> addToWishlist(int productId) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.wishlist}/$productId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'productId': productId}),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return WishlistItem.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add item to wishlist');
    }
  }

  // remove product from wishlist
  Future<void> removeFromWishlist(int wishlistItemId) async {
    final response = await http.delete(
      Uri.parse('${ApiConfig.wishlist}/$wishlistItemId'),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to remove item from wishlist');
    }
  }




}