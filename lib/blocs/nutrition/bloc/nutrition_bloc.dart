import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synew_gym/models/custom_error.dart';
import 'package:synew_gym/models/daily_logs.dart';
import 'package:synew_gym/models/food.dart';
import 'package:synew_gym/models/user_daily_nutrition.dart';
import 'package:synew_gym/blocs/nutrition/repository/nutrition_repository.dart';

part 'nutrition_event.dart';
part 'nutrition_state.dart';

class NutritionBloc extends Bloc<NutritionEvent, NutritionState> {
  final NutritionRepository nutritionRepository;

  NutritionBloc({required this.nutritionRepository})
      : super(NutritionState.initial()) {
    on<FetchNutrientDataEvent>(((event, emit) async {
      emit(state.copyWith(nutririonStatus: NutririonStatus.loading));
      try {
        UserFoodNutrition userFoodNutrition = await nutritionRepository
            .fetchUserNutrientsData(event.uid, state.selectedDate);
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

    on<UpdateCurrentWaterConsumedEvent>(((event, emit) async {
      emit(state.copyWith(nutririonStatus: NutririonStatus.loading));
      try {
        if (event.waterConsumed != '') {
          UserFoodNutrition updatedUserFoodNutrition = state.userFoodNutrition
              .copyWith(
                  totalWater: state.userFoodNutrition.totalWater +
                      (double.parse(event.waterConsumed)));

          emit(state.copyWith(
            userFoodNutrition: updatedUserFoodNutrition,
            nutririonStatus: NutririonStatus.loaded,
          ));
        }
      } catch (e) {
        emit(state.copyWith(nutririonStatus: NutririonStatus.error));
      }
    }));

    on<StoreCurrentWaterConsumedEvent>(((event, emit) async {
      try {
        UserFoodNutrition updatedUserFoodNutrition = state.userFoodNutrition;
        await nutritionRepository.updateUserFoodNutritionInFirebase(
            uid: event.uid,
            updatedUserFoodNutrition: updatedUserFoodNutrition,
            date: state.selectedDate);
      } catch (e) {
        emit(state.copyWith(nutririonStatus: NutririonStatus.error));
      }
    }));

    on<UpdateGoalsEvent>(((event, emit) async {
      emit(state.copyWith(nutririonStatus: NutririonStatus.loading));
      try {
        await nutritionRepository.updateGoals(
          event.uid,
          state.userFoodNutrition.goalCalories,
          state.userFoodNutrition.goalFat,
          state.userFoodNutrition.goalProtein,
          state.userFoodNutrition.goalCarbs,
          state.userFoodNutrition.goalWater,
          state.selectedDate,
        );
        emit(state.copyWith(
          nutririonStatus: NutririonStatus.loaded,
        ));
      } catch (e) {
        emit(state.copyWith(nutririonStatus: NutririonStatus.error));
      }
    }));

    on<UpdateGoalCaloriesEvent>(((event, emit) async {
      emit(state.copyWith(nutririonStatus: NutririonStatus.loading));
      try {
        if (event.goalCalories != '') {
          double updatedGoal = double.parse(event.goalCalories);
          UserFoodNutrition updatedUserFoodNutrition =
              state.userFoodNutrition.copyWith(goalCalories: updatedGoal);
          emit(state.copyWith(
            nutririonStatus: NutririonStatus.loaded,
            userFoodNutrition: updatedUserFoodNutrition,
          ));
        }
      } catch (e) {
        emit(state.copyWith(nutririonStatus: NutririonStatus.error));
      }
    }));

    on<UpdateGoalCarbsEvent>(((event, emit) async {
      emit(state.copyWith(nutririonStatus: NutririonStatus.loading));
      try {
        if (event.goalCarbs != '') {
          double updatedGoal = double.parse(event.goalCarbs);
          UserFoodNutrition updatedUserFoodNutrition =
              state.userFoodNutrition.copyWith(goalCarbs: updatedGoal);
          emit(state.copyWith(
            nutririonStatus: NutririonStatus.loaded,
            userFoodNutrition: updatedUserFoodNutrition,
          ));
        }
      } catch (e) {
        emit(state.copyWith(nutririonStatus: NutririonStatus.error));
      }
    }));

    on<UpdateGoalProteinsEvent>(((event, emit) async {
      emit(state.copyWith(nutririonStatus: NutririonStatus.loading));
      try {
        if (event.goalProteins != '') {
          double updatedGoal = double.parse(event.goalProteins);
          UserFoodNutrition updatedUserFoodNutrition =
              state.userFoodNutrition.copyWith(goalProtein: updatedGoal);
          emit(state.copyWith(
            nutririonStatus: NutririonStatus.loaded,
            userFoodNutrition: updatedUserFoodNutrition,
          ));
        }
      } catch (e) {
        emit(state.copyWith(nutririonStatus: NutririonStatus.error));
      }
    }));

    on<UpdateGoalFatsEvent>(((event, emit) async {
      emit(state.copyWith(nutririonStatus: NutririonStatus.loading));
      try {
        if (event.goalFats != '') {
          double updatedGoal = double.parse(event.goalFats);
          UserFoodNutrition updatedUserFoodNutrition =
              state.userFoodNutrition.copyWith(goalFat: updatedGoal);
          emit(state.copyWith(
            nutririonStatus: NutririonStatus.loaded,
            userFoodNutrition: updatedUserFoodNutrition,
          ));
        }
      } catch (e) {
        emit(state.copyWith(nutririonStatus: NutririonStatus.error));
      }
    }));

    on<UpdateGoalWaterEvent>(((event, emit) async {
      emit(state.copyWith(nutririonStatus: NutririonStatus.loading));
      try {
        if (event.goalWater != '') {
          double updatedGoal = double.parse(event.goalWater);
          UserFoodNutrition updatedUserFoodNutrition =
              state.userFoodNutrition.copyWith(goalWater: updatedGoal);
          emit(state.copyWith(
            nutririonStatus: NutririonStatus.loaded,
            userFoodNutrition: updatedUserFoodNutrition,
          ));
        }
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
            date: state.selectedDate);
      } catch (e) {
        emit(state.copyWith(
            nutririonStatus: NutririonStatus.error,
            error: CustomError(message: e.toString())));
      }
    }));
  }
}
