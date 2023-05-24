import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:synew_gym/constants/db_constants.dart';
import 'package:synew_gym/models/food.dart';
import 'package:synew_gym/models/user_daily_nutrition.dart';
import 'package:synew_gym/blocs/nutrition/services/nutrition_api_services.dart';

class NutritionRepository {
  final NutritionApiServices nutritionApiServices;
  NutritionRepository({
    required this.nutritionApiServices,
  });

  Future<UserFoodNutrition> fetchUserNutrientsData(String uid) async {
    final DocumentSnapshot userNutrientsDoc = await nutrientsRef.doc(uid).get();
    if (userNutrientsDoc.exists) {
      return UserFoodNutrition.fromJson(
          userNutrientsDoc.data() as Map<String, dynamic>);
    } else {
      await nutrientsRef.doc(uid).set(UserFoodNutrition.initial().toJson());
      return UserFoodNutrition.initial();
    }
  }

  Future<void> updateUserFoodNutritionInFirebase({
    required String uid,
    required UserFoodNutrition updatedUserFoodNutrition,
  }) async {
    await nutrientsRef.doc(uid).update(updatedUserFoodNutrition.toJson());
  }

  Future<void> updateGoals(String uid, double goalCalories, double goalFat,
      double goalProtein, double goalCarbs) async {
    DocumentReference nutrientsDoc = nutrientsRef.doc(uid);
    await nutrientsDoc.update({
      'goalCalories': goalCalories,
      'goalFat': goalFat,
      'goalProtein': goalProtein,
      'goalCarbs': goalCarbs,
    });
  }

  Future<void> updateGoalWater(String uid, int waterGoal) async {
    DocumentReference nutrientsDoc = nutrientsRef.doc(uid);
    await nutrientsDoc.update({'goalWater': waterGoal});
  }

  Future<void> updateGoalCarbs(String uid, double carbsGoal) async {
    DocumentReference nutrientsDoc = nutrientsRef.doc(uid);
    await nutrientsDoc.update({'goalCarbs': carbsGoal});
  }

  Future<void> updateGoalFat(String uid, double fatGoal) async {
    DocumentReference nutrientsDoc = nutrientsRef.doc(uid);
    await nutrientsDoc.update({'goalFat': fatGoal});
  }

  Future<void> updateGoalProtein(String uid, double proteinGoal) async {
    DocumentReference nutrientsDoc = nutrientsRef.doc(uid);
    await nutrientsDoc.update({'goalProtein': proteinGoal});
  }

  Future<void> updateGoalCalories(String uid, double caloriesGoal) async {
    DocumentReference nutrientsDoc = nutrientsRef.doc(uid);
    await nutrientsDoc.update({'goalCalories': caloriesGoal});
  }

  Future<List<Food>> searchFood(String query) async {
    List<Food> foodItems = await nutritionApiServices.searchFood(query);
    return foodItems;
  }

  Future<Food> searchAndAddFoodItem(String itemId) async {
    Food food = await nutritionApiServices.fetchNutritionData(itemId);
    return food;
  }
}
