import 'package:eshop_client/providers/wishlist_provider.dart';
import 'package:eshop_client/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/catalog_provider.dart';
import '../widgets/product_card.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CatalogProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions:[
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
                    MaterialPageRoute(builder: (context) => const WishlistScreen(),
                    ),
                  );
                }
              );
            },
          ),
          const SizedBox(width: 8),
        ]
        ),
      body: vm.loading
          ? const Center(child: CircularProgressIndicator())
          : vm.error != null
              ? Center(child: Text('Error: ${vm.error}'))
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: .8,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: vm.products.length,
                  itemBuilder: (_, i) {
                    final product = vm.products[i];
                    return ProductCard(
                      product: product,
                      onAddToCart: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${product.name} added to cart')),
                        );
                      },
                      onAddToWishlist: () async {
                        await context.read<WishlistProvider>().addToWishlist(product.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${product.name} added to wishlist')),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
