import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/feature_flags.dart';

class FlagService {
  final String baseUrl;
  FlagService(this.baseUrl);

  Future<FeatureFlags> fetchFlags() async {
    final res = await http.get(Uri.parse('$baseUrl/flags'));
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body) as Map<String, dynamic>;
      return FeatureFlags.fromJson(json);
    }
    return FeatureFlags.empty;
  }
}
