// lib/screens/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item_tile.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: cart.loading
          ? const Center(child: CircularProgressIndicator())
          : cart.error != null
              ? Center(child: Text('Error: ${cart.error}'))
              : cart.items.isEmpty
                  ? const Center(child: Text('Your cart is empty'))
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: cart.items.length,
                            itemBuilder: (_, i) => CartItemTile(
                              cartItem: cart.items[i],
                              onRemove: () => cart.removeFromCart(cart.items[i].id),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text('Total: QAR ${cart.totalAmount.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: cart.items.isEmpty
                                    ? null
                                    : () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                                        );
                                      },
                                child: const Text('Proceed to Checkout'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
    );
  }
}
