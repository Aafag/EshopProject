// lib/screens/order_history_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';
import '../widgets/empty_state.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrderProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: orders.loading
          ? const Center(child: CircularProgressIndicator())
          : orders.error != null
              ? Center(child: Text('Error: ${orders.error}'))
              : orders.orders.isEmpty
                  ? const EmptyState(message: 'No past orders found')
                  : ListView.builder(
                      itemCount: orders.orders.length,
                      itemBuilder: (_, i) {
                        final order = orders.orders[i];
                        return ListTile(
                          title: Text('Order #${order.id}'),
                          subtitle: Text(
                            'Total: QAR ${order.totalAmount.toStringAsFixed(2)} • ${order.status}',
                          ),
                          trailing: Text(
                            order.createdAt.toLocal().toString().split(' ')[0],
                            style: const TextStyle(color: Colors.grey),
                          ),
                        );
                      },
                    ),
    );
  }
}
