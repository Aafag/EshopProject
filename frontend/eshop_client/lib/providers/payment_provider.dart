// lib/providers/payment_provider.dart
import 'package:flutter/foundation.dart';
import '../models/payment_option.dart';
import '../services/payment_service.dart';

class PaymentProvider extends ChangeNotifier {
  final PaymentService _service = PaymentService();

  List<PaymentOption> _options = [];
  bool _loading = false;
  String? _error;

  List<PaymentOption> get options => _options;
  bool get loading => _loading;
  String? get error => _error;

  Future<void> loadPaymentOptions() async {
    _loading = true;
    notifyListeners();
    try {
      _options = await _service.getPaymentOptions();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
