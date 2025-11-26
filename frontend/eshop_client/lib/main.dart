import 'package:eshop_client/providers/cart_provider.dart';
import 'package:eshop_client/providers/order_provider.dart';
import 'package:eshop_client/providers/payment_provider.dart';
import 'package:eshop_client/providers/wishlist_provider.dart';
import 'package:eshop_client/utils/navigator_key.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/catalog_provider.dart';
import 'screens/product_list_screen.dart';

void main() {
  runApp(const EshopApp());
}
class EshopApp extends StatelessWidget {
  const EshopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // CatalogProvider will fetch products from your backend
        ChangeNotifierProvider(create: (_) => CatalogProvider()..loadProducts()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()..loadWishlist()),
        ChangeNotifierProvider(create: (_) => CartProvider()..loadCart()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()..loadPaymentOptions()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'E-Shop',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.indigo,
        ),
        home: const ProductListScreen(),
      ),
    );
  }
}
