// lib/services/payment_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/payment_option.dart';

class PaymentService {
  // Get all payment options
  Future<List<PaymentOption>> getPaymentOptions() async {
    final res = await http.get(Uri.parse(ApiConfig.paymentOptions));
    if (res.statusCode != 200) throw Exception('Failed to load payment options');
    final List<dynamic> data = json.decode(res.body);
    return data.map((e) => PaymentOption.fromJson(e)).toList();
  }
}
