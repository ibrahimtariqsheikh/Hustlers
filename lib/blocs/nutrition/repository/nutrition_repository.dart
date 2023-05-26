import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:synew_gym/constants/db_constants.dart';
import 'package:synew_gym/models/custom_error.dart';
import 'package:synew_gym/models/food.dart';
import 'package:synew_gym/models/user_daily_nutrition.dart';
import 'package:synew_gym/blocs/nutrition/services/nutrition_api_services.dart';

class NutritionRepository {
  final NutritionApiServices nutritionApiServices;
  NutritionRepository({
    required this.nutritionApiServices,
  });

  Future<UserFoodNutrition> fetchUserNutrientsData(
      String uid, String date) async {
    final DocumentSnapshot userNutrientsDoc = await nutrientsRef
        .doc(uid)
        .collection('NutritionDataByDate')
        .doc(date)
        .get();
    if (userNutrientsDoc.exists) {
      return UserFoodNutrition.fromJson(
          userNutrientsDoc.data() as Map<String, dynamic>);
    } else {
      await nutrientsRef
          .doc(uid)
          .collection('NutritionDataByDate')
          .doc(date)
          .set(UserFoodNutrition.initial().toJson());
      return UserFoodNutrition.initial();
    }
  }

  Future<void> updateUserFoodNutritionInFirebase({
    required String uid,
    required UserFoodNutrition updatedUserFoodNutrition,
    required String date,
  }) async {
    try {
      await nutrientsRef
          .doc(uid)
          .collection('NutritionDataByDate')
          .doc(date)
          .update(updatedUserFoodNutrition.toJson());
    } catch (e) {
      CustomError(code: '404', message: e.toString());
    }
  }

  Future<void> updateGoals(String uid, double goalCalories, double goalFat,
      double goalProtein, double goalCarbs, double goalWater) async {
    DocumentReference nutrientsDoc = nutrientsRef
        .doc(uid)
        .collection('NutritionDataByDate')
        .doc(
            '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}');
    await nutrientsDoc.update({
      'goalCalories': goalCalories,
      'goalFat': goalFat,
      'goalProtein': goalProtein,
      'goalCarbs': goalCarbs,
      'goalWater': goalWater,
    });
  }

  Future<void> updateGoalWater(String uid, double waterGoal) async {
    DocumentReference nutrientsDoc = nutrientsRef
        .doc(uid)
        .collection('NutritionDataByDate')
        .doc(
            '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}');
    await nutrientsDoc.update({'goalWater': waterGoal});
  }

  Future<void> updateGoalCarbs(String uid, double carbsGoal) async {
    DocumentReference nutrientsDoc = nutrientsRef
        .doc(uid)
        .collection('NutritionDataByDate')
        .doc(
            '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}');
    await nutrientsDoc.update({'goalCarbs': carbsGoal});
  }

  Future<void> updateGoalFat(String uid, double fatGoal) async {
    DocumentReference nutrientsDoc = nutrientsRef
        .doc(uid)
        .collection('NutritionDataByDate')
        .doc(
            '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}');
    await nutrientsDoc.update({'goalFat': fatGoal});
  }

  Future<void> updateGoalProtein(String uid, double proteinGoal) async {
    DocumentReference nutrientsDoc = nutrientsRef
        .doc(uid)
        .collection('NutritionDataByDate')
        .doc(
            '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}');
    await nutrientsDoc.update({'goalProtein': proteinGoal});
  }

  Future<void> updateGoalCalories(String uid, double caloriesGoal) async {
    DocumentReference nutrientsDoc = nutrientsRef
        .doc(uid)
        .collection('NutritionDataByDate')
        .doc(
            '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}');
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
