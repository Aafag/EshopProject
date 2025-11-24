// lib/models/payment_option.dart
enum PaymentMethod { CREDIT_CARD, PAYPAL, CASH_ON_DELIVERY }

class PaymentOption {
  final int id;
  final PaymentMethod method;
  final String displayName;

  PaymentOption({
    required this.id,
    required this.method,
    required this.displayName,
  });

  factory PaymentOption.fromJson(Map<String, dynamic> json) {
    return PaymentOption(
      id: json['id'],
      method: PaymentMethod.values.firstWhere(
        (m) => m.toString().split('.').last == json['method'],
        orElse: () => PaymentMethod.CREDIT_CARD,
      ),
      displayName: json['displayName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'method': method.toString().split('.').last,
      'displayName': displayName,
    };
  }
}
