// lib/screens/checkout_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/payment_provider.dart';
import '../providers/order_provider.dart';
import 'order_processing_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final payments = context.watch<PaymentProvider>();
    final orders = context.read<OrderProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Payment Method'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: payments.loading
          ? const Center(child: CircularProgressIndicator())
          : payments.error != null
              ? Center(child: Text('Error: ${payments.error}'))
              : payments.options.isEmpty
                  ? const Center(child: Text('No payment methods available'))
                  : ListView.builder(
                      itemCount: payments.options.length,
                      itemBuilder: (_, i) {
                        final option = payments.options[i];

                        IconData icon;
                        switch (option.method) {
                          case 'CREDIT_CARD':
                            icon = Icons.credit_card;
                            break;
                          case 'PAYPAL':
                            icon = Icons.paypal;
                            break;
                          default:
                            icon = Icons.payment;
                        }

                        return Card(
                          margin: const EdgeInsets.all(12),
                          child: ListTile(
                            leading: Icon(icon, size: 40, color: Colors.indigo),
                            title: Text(
                              option.displayName,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                foregroundColor: Colors.white,
                              ),
                            onPressed: () async {
                              try {
                                final order = await orders.placeOrder(option.id);
                                if (order != null && context.mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => OrderProcessingScreen(
                                        orderId: order.id!,
                                        paymentMethod: option.displayName,
                                      ),
                                    ),
                                  );
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Order failed: $e', style: TextStyle(color: Colors.white)),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              }
                            },                              
                            child: const Text('Select'),
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}