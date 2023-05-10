import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:synew_gym/models/products.dart';

class SanityApiServices {
  Future<List<Product>> fetchData(String fetchAllQuery) async {
    final response = await http.get(Uri.parse(
        'https://ro9z7q78.api.sanity.io/v1/data/query/production?query=$fetchAllQuery'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;

      final products = data['result'];
      List<Product> productItems = [];
      for (final item in products) {
        Product product = Product.fromJson(item);
        productItems.add(product);
      }

      return productItems;
    } else {
      throw Exception('Failed to load clothing items');
    }
  }
}