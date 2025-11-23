import 'package:flutter/material.dart';
import '../models/wishlist_item.dart';

// Single wishlist item tile widget
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
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/${product.imageName}', // ✅ Local asset image
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.image, size: 80),
              ),
            ),

            const SizedBox(width: 16),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'QAR ${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ),
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
                color: Colors.red,
              ),
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
