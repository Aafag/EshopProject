// lib/screens/checkout_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/payment_provider.dart';
import '../providers/order_provider.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final payments = context.watch<PaymentProvider>();
    final orders = context.read<OrderProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: payments.loading
          ? const Center(child: CircularProgressIndicator())
          : payments.error != null
              ? Center(child: Text('Error: ${payments.error}'))
              : ListView.builder(
                  itemCount: payments.options.length,
                  itemBuilder: (_, i) {
                    final option = payments.options[i];
                    return ListTile(
                      title: Text(option.displayName),
                      trailing: ElevatedButton(
                        child: const Text('Select'),
                        onPressed: () async {
                          final order = await orders.placeOrder(option.id);
                          if (order != null && context.mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => OrderSuccessScreen(orderId: order.id),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
