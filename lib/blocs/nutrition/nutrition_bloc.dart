import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synew_gym/models/custom_error.dart';
import 'package:synew_gym/models/daily_logs.dart';
import 'package:synew_gym/models/food.dart';
import 'package:synew_gym/models/user_daily_nutrition.dart';
import 'package:synew_gym/repositories/nutrition_repository.dart';

part 'nutrition_event.dart';
part 'nutrition_state.dart';

class NutritionBloc extends Bloc<NutritionEvent, NutritionState> {
  final NutritionRepository nutritionRepository;

  NutritionBloc({required this.nutritionRepository})
      : super(NutritionState.initial()) {
    on<FetchNutrientDataEvent>(((event, emit) async {
      emit(state.copyWith(nutririonStatus: NutririonStatus.loading));
      try {
        UserFoodNutrition userFoodNutrition =
            await nutritionRepository.fetchUserNutrientsData(event.uid);

        emit(state.copyWith(
          userFoodNutrition: userFoodNutrition,
          nutririonStatus: NutririonStatus.loaded,
        ));
      } catch (e) {
        emit(state.copyWith(
            nutririonStatus: NutririonStatus.error,
            error: CustomError(
              plugin: 'Fetching Error',
              code: '404',
              message: e.toString(),
            )));
      }
    }));
    on<UpdateWaterConsumedEvent>(((event, emit) async {
      emit(state.copyWith(nutririonStatus: NutririonStatus.loading));
      try {
        double updatedWater = state.userFoodNutrition.totalWater +
            double.parse(event.waterConsumed);
        UserFoodNutrition updatedUserFoodNutrition =
            state.userFoodNutrition.copyWith(totalWater: updatedWater);
        emit(state.copyWith(
          nutririonStatus: NutririonStatus.loaded,
          userFoodNutrition: updatedUserFoodNutrition,
        ));
      } catch (e) {
        emit(state.copyWith(nutririonStatus: NutririonStatus.error));
      }
    }));
    on<UpdateGoalCaloriesEvent>(((event, emit) async {
      emit(state.copyWith(nutririonStatus: NutririonStatus.loading));
      try {
        UserFoodNutrition updatedUserFoodNutrition = state.userFoodNutrition
            .copyWith(goalCalories: event.goalCalories.toDouble());
        emit(state.copyWith(
          nutririonStatus: NutririonStatus.loaded,
          userFoodNutrition: updatedUserFoodNutrition,
        ));
        await nutritionRepository.updateGoalCalories(
            event.uid, (event.goalCalories).toDouble());
      } catch (e) {
        emit(state.copyWith(nutririonStatus: NutririonStatus.error));
      }
    }));
    on<UpdateGoalCarbsEvent>(((event, emit) async {
      emit(state.copyWith(nutririonStatus: NutririonStatus.loading));
      try {
        UserFoodNutrition updatedUserFoodNutrition = state.userFoodNutrition
            .copyWith(goalCarbs: (event.goalCarbs).toDouble());
        emit(state.copyWith(
          nutririonStatus: NutririonStatus.loaded,
          userFoodNutrition: updatedUserFoodNutrition,
        ));
        await nutritionRepository.updateGoalCarbs(
            event.uid, (event.goalCarbs).toDouble());
      } catch (e) {
        emit(state.copyWith(nutririonStatus: NutririonStatus.error));
      }
    }));
    on<UpdateGoalProteinsEvent>(((event, emit) async {
      emit(state.copyWith(nutririonStatus: NutririonStatus.loading));
      try {
        UserFoodNutrition updatedUserFoodNutrition = state.userFoodNutrition
            .copyWith(goalProtein: (event.goalProteins).toDouble());
        emit(state.copyWith(
          nutririonStatus: NutririonStatus.loaded,
          userFoodNutrition: updatedUserFoodNutrition,
        ));
        await nutritionRepository.updateGoalProtein(
            event.uid, (event.goalProteins).toDouble());
        emit(state.copyWith(nutririonStatus: NutririonStatus.error));
      } catch (e) {
        emit(state.copyWith(nutririonStatus: NutririonStatus.error));
      }
    }));

    on<UpdateGoalFatsEvent>(((event, emit) async {
      emit(state.copyWith(nutririonStatus: NutririonStatus.loading));
      try {
        UserFoodNutrition updatedUserFoodNutrition = state.userFoodNutrition
            .copyWith(goalFat: (event.goalFats).toDouble());
        emit(state.copyWith(
          nutririonStatus: NutririonStatus.loaded,
          userFoodNutrition: updatedUserFoodNutrition,
        ));
        await nutritionRepository.updateGoalFat(
          event.uid,
          (event.goalFats).toDouble(),
        );
      } catch (e) {
        emit(state.copyWith(nutririonStatus: NutririonStatus.error));
      }
    }));

    on<FetchNutritionInfoEvent>(((event, emit) async {
      emit(state.copyWith(nutririonStatus: NutririonStatus.loading));
      try {
        final List<Food> foodItems =
            await nutritionRepository.searchFood(event.query);
        emit(state.copyWith(
          nutririonStatus: NutririonStatus.loaded,
          foodItems: foodItems,
        ));
      } catch (e) {
        emit(state.copyWith(nutririonStatus: NutririonStatus.error));
      }
    }));

    on<FetchAndAddFoodItemEvent>(((event, emit) async {
      emit(state.copyWith(nutririonStatus: NutririonStatus.loading));
      try {
        final Food food =
            await nutritionRepository.searchAndAddFoodItem(event.itemId);

        List<DailyLogs> updatedDailyLogs =
            List<DailyLogs>.from(state.userFoodNutrition.dailyLogs);

        int dailyLogIndex = updatedDailyLogs
            .indexWhere((log) => log.type == event.foodCardType);

        double totalTypeCarbs =
            updatedDailyLogs[dailyLogIndex].totalCarbs + food.totalCarbs;
        double totalTypeFat =
            updatedDailyLogs[dailyLogIndex].totalFat + food.totalFat;
        double totalTypeProtein =
            updatedDailyLogs[dailyLogIndex].totalProtein + food.protein;
        double totalTypeCalories =
            updatedDailyLogs[dailyLogIndex].totalCalories + food.calories;
        DailyLogs updatedDailyLog = updatedDailyLogs[dailyLogIndex].copyWith(
          foodList: List<Food>.from(updatedDailyLogs[dailyLogIndex].foodList)
            ..add(food),
          totalCarbs: totalTypeCarbs,
          totalFat: totalTypeFat,
          totalProtein: totalTypeProtein,
          totalCalories: totalTypeCalories,
        );

        UserFoodNutrition updatedUserFoodNutrition =
            state.userFoodNutrition.copyWith(
          dailyLogs: updatedDailyLogs,
          totalCalories: state.userFoodNutrition.totalCalories + food.calories,
          totalCarbs: state.userFoodNutrition.totalCarbs + food.totalCarbs,
          totalFat: state.userFoodNutrition.totalFat + food.totalFat,
          totalProtein: state.userFoodNutrition.totalProtein + food.protein,
        );

        updatedDailyLogs[dailyLogIndex] = updatedDailyLog;

        emit(state.copyWith(
          nutririonStatus: NutririonStatus.loaded,
          userFoodNutrition: updatedUserFoodNutrition,
        ));
        await nutritionRepository.updateUserFoodNutritionInFirebase(
          uid: event.uid,
          updatedUserFoodNutrition: updatedUserFoodNutrition,
        );
      } catch (e) {
        emit(state.copyWith(
            nutririonStatus: NutririonStatus.error,
            error: CustomError(message: e.toString())));
      }
    }));
  }
}
