import 'package:eshop_client/providers/wishlist_provider.dart';
import 'package:eshop_client/providers/cart_provider.dart';
import 'package:eshop_client/screens/wishlist_screen.dart';
import 'package:eshop_client/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/catalog_provider.dart';
import '../providers/feature_flag_provider.dart'; // 🔹 NEW
import '../widgets/product_card.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CatalogProvider>();
    final flags = context.watch<FeatureFlagProvider>().flags; // 🔹 read flags

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          // 🔄 Refresh flags button
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh features',
            onPressed: () async {
              await context.read<FeatureFlagProvider>().refresh();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Features updated')),
              );
            },
          ),

          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Consumer<CatalogProvider>(
              builder: (context, catalog, child) {
                final categories = [
                  'All',
                  ...catalog.products
                      .map((p) => p.categoryName ?? 'Unknown')
                      .toSet()
                      .toList()
                ];

                return DropdownButton<String>(
                  value: catalog.selectedCategory,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                  dropdownColor: Colors.indigo[800],
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  items: categories.map((cat) {
                    return DropdownMenuItem(
                      value: cat,
                      child: Text(cat),
                    );
                  }).toList(),
                  onChanged: (value) {
                    catalog.setCategoryFilter(value ?? 'All');
                  },
                );
              },
            ),
          ),

          // ✅ Wishlist icon only if flag is enabled
          if (flags.wishlistEnabled)
            Consumer<WishlistProvider>(
              builder: (context, wishlist, child) {
                return IconButton(
                  icon: Badge(
                    label: Text('${wishlist.itemCount}'),
                    isLabelVisible: wishlist.itemCount > 0,
                    child: const Icon(Icons.favorite_border),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WishlistScreen(),
                      ),
                    );
                  },
                );
              },
            ),
          const SizedBox(width: 8),

          // Cart icon with badge
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return IconButton(
                icon: Badge(
                  label: Text('${cart.itemCount}'),
                  isLabelVisible: cart.itemCount > 0,
                  child: const Icon(Icons.shopping_cart),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // ✅ Search bar only if flag is enabled
          if (flags.searchEnabled)
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search products...',
                  border: OutlineInputBorder(),
                ),
                onChanged: (query) {
                  context.read<CatalogProvider>().setSearchQuery(query);
                },
              ),
            ),

          // ✅ Flash sale banner
          if (flags.flashSale)
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                '🔥 Flash Sale Active!',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),

          Expanded(
            child: vm.loading
                ? const Center(child: CircularProgressIndicator())
                : vm.error != null
                    ? Center(child: Text('Error: ${vm.error}'))
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: .8,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: vm.filteredProducts.length,
                        itemBuilder: (_, i) {
                          final product = vm.filteredProducts[i];
                          return ProductCard(
                            product: product,
                            onAddToCart: () {
                              context.read<CartProvider>().addToCart(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${product.name} added to cart'),
                                ),
                              );
                            },
                            onAddToWishlist: () async {
                              await context
                                  .read<WishlistProvider>()
                                  .addToWishlist(product.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${product.name} added to wishlist'),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
