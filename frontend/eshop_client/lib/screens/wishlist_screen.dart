import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wishlist_provider.dart';
import '../widgets/wishlist_item_tile.dart';

class WishlistScreen extends StatelessWidget{
  const WishlistScreen({super.key});



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        actions: [
          Consumer<WishlistProvider>(
            builder: (context, wishlist, child) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Text(
                    '${wishlist.itemCount} items', // e.g., "3 items"
                    style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                 ),
                ),
              );
            },
          ),
        ],
      ),
      
      body: Consumer<WishlistProvider>(
        builder: (context, wishlist, child) {
          // Show loading indicator while wishlist is being fetched
          if (wishlist.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Show error message if there was a problem fetching data
          if (wishlist.error != null) {
            return Center(child: Text('Error: ${wishlist.error}'));
          }

          // Show placeholder if wishlist is empty
          if (wishlist.wishlistItems.isEmpty) {
            return const Center(
              child: Text(
                'Your wishlist is empty',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          // Display the list of wishlist items
          return ListView.builder(
            itemCount: wishlist.wishlistItems.length, // Number of items
            itemBuilder: (context, index) {
              final item = wishlist.wishlistItems[index];

              // Each item is displayed using WishlistItemTile
              return WishlistItemTile(
                wishlistItem: item,
                // Pass a callback to remove item from wishlist
                onRemove: () => wishlist.removeFromWishlist(item.id),
              );
            },
          );
        },
      ),
    );
  }
}