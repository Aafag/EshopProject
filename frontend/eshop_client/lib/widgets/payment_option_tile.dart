// lib/widgets/payment_option_tile.dart
import 'package:flutter/material.dart';
import '../models/payment_option.dart';

class PaymentOptionTile extends StatelessWidget {
  final PaymentOption option;
  final VoidCallback onSelect;

  const PaymentOptionTile({
    super.key,
    required this.option,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    IconData icon;
    switch (option.method) {
      case PaymentMethod.CREDIT_CARD:
        icon = Icons.credit_card;
        break;
      case PaymentMethod.PAYPAL:
        icon = Icons.account_balance_wallet;
        break;
      case PaymentMethod.CASH_ON_DELIVERY:
        icon = Icons.money;
        break;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(icon, size: 32, color: Colors.indigo),
        title: Text(option.displayName),
        trailing: ElevatedButton(
          onPressed: onSelect,
          child: const Text('Select'),
        ),
      ),
    );
  }
}
