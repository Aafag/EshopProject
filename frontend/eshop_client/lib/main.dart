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
      ],
      child: MaterialApp(
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
