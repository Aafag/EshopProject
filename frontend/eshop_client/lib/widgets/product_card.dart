import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;
  final VoidCallback? onAddToWishlist; // ✅ make it nullable

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
    this.onAddToWishlist, // ✅ not required anymore
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/${product.imageName}',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.image),
            ),
          ),
          ListTile(
            title: Text(product.name,
                maxLines: 1, overflow: TextOverflow.ellipsis),
            subtitle: Text('QAR ${product.price.toStringAsFixed(2)}'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Text('Stock: ${product.stock}'),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: onAddToWishlist, // ✅ safe, can be null
                ),
                FilledButton(
                  onPressed: onAddToCart,
                  child: const Text('Add To Cart'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
