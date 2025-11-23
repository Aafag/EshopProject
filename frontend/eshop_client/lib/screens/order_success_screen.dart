// lib/screens/order_success_screen.dart
import 'package:flutter/material.dart';

class OrderSuccessScreen extends StatelessWidget {
  final int orderId;

  const OrderSuccessScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Success')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 16),
            Text(
              'Your order #$orderId has been placed successfully!',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
