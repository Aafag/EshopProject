import 'package:flutter/material.dart';
import '../models/wishlist_item.dart';


//single wishlist item tile widget
class WishlistItemTile extends StatelessWidget {
  final WishlistItem wishlistItem;

  /// Callback when the remove button is pressed
  final VoidCallback onRemove; 

  const WishlistItemTile({
    super.key,
    required this.wishlistItem,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    // Get the related product from the wishlist item
    final product = wishlistItem.product;

    return Card(
      // Outer spacing around the tile
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        // Inner spacing inside the card
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8), // Rounded corners
              child: Image.network(
                product.imageUrl,  // Image URL from product model
                width: 80,
                height: 80,
                fit: BoxFit.cover, // Crop image to fill the space
                // If image fails to load, show an icon instead
                errorBuilder: (_, __, ___) => const Icon(Icons.image, size: 80),
              ),
            ),

            const SizedBox(width: 16),
            // Product Details
            Expanded(
              // Expands to take remaining horizontal space
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product name
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis, // Trims long text
                  ),

                  const SizedBox(height: 4),

                  // Product price
                  Text(
                    'QAR ${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),

                  // Show "Out of stock" if stock == 0
                  if (product.stock == 0)
                    const Text(
                      'Out of stock',
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),

            // Remove Button
            IconButton(
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red, // Red delete icon
              ),
              onPressed: onRemove, // Calls the callback passed from parent
            ),
          ],
        ),
      ),
    );
  }
}
