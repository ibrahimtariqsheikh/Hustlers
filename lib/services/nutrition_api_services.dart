import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:synew_gym/models/food.dart';
import '../.env';

class NutritionApiServices {
  Future<List<Food>> searchFood(String query) async {
    final uri = Uri.parse(
        'https://trackapi.nutritionix.com/v2/search/instant?query=$query&branded_type=1');
    final response = await http.get(uri, headers: {
      'x-app-id': NUTRITIONIX_APP_ID,
      'x-app-key': NUTRITIONIX_APP_KEY,
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final branded = data['branded'] as List<dynamic>;

      List<Food> foodItems = [];

      for (final item in branded) {
        Food foodItem = Food.fromJson(item);
        foodItems.add(foodItem);
      }

      return foodItems;
    } else {
      throw Exception('Failed to load food items');
    }
  }

  Future<Food> fetchNutritionData(String itemId) async {
    final uri = Uri.parse(
        'https://trackapi.nutritionix.com/v2/search/item?nix_item_id=$itemId');
    final response = await http.get(
      uri,
      headers: {
        'x-app-id': NUTRITIONIX_APP_ID,
        'x-app-key': NUTRITIONIX_APP_KEY,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;

      if (data.containsKey('foods') && data['foods'].isNotEmpty) {
        final foods = data['foods'] as List<dynamic>;
        Food foodItem = Food.fromJson(foods[0]);
        return foodItem;
      } else {
        throw Exception('No food items found');
      }
    } else {
      throw Exception('Failed to load nutrition data');
    }
  }
}
