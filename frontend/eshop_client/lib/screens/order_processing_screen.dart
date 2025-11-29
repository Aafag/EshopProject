// lib/screens/order_processing_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'order_success_screen.dart';

class OrderProcessingScreen extends StatefulWidget {
  final int orderId;
  final String paymentMethod;

  const OrderProcessingScreen({
    super.key,
    required this.orderId,
    required this.paymentMethod,
  });

  @override
  State<OrderProcessingScreen> createState() => _OrderProcessingScreenState();
}

class _OrderProcessingScreenState extends State<OrderProcessingScreen> {
  @override
  void initState() {
    super.initState();
    _completePayment();
  }

  Future<void> _completePayment() async {
    // Mark order as COMPLETED
    try {
      await http.put(
        Uri.parse('http://localhost:8080/api/orders/${widget.orderId}/done-payment'),
      );
    } catch (e) {
      print("Demo mode: $e");
    }

    // Wait 3 seconds then go to success
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => OrderSuccessScreen(orderId: widget.orderId),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline, size: 100, color: Colors.white),
            const SizedBox(height: 32),
            const Text(
              "Thank You!",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              "Your order #${widget.orderId} is being processed",
              style: const TextStyle(fontSize: 18, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "Payment: ${widget.paymentMethod}",
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              "Please wait...",
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}