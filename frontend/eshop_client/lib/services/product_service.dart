import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/product.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    final res = await http.get(Uri.parse(ApiConfig.products));
    if (res.statusCode != 200) throw Exception('Failed to load products');
    final body = json.decode(res.body);
    final List list = body['content'] ?? body;
    return list.map((e) => Product.fromJson(e)).toList();
  }

  Future<Product> fetchProduct(int id) async {
    final res = await http.get(Uri.parse('${ApiConfig.products}/$id'));
    if (res.statusCode != 200) throw Exception('Product not found');
    return Product.fromJson(json.decode(res.body));
  }
}
