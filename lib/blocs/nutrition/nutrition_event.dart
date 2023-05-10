part of 'nutrition_bloc.dart';

abstract class NutritionEvent extends Equatable {
  const NutritionEvent();
}

class FetchNutritionInfoEvent extends NutritionEvent {
  final String query;

  const FetchNutritionInfoEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class FetchAndAddFoodItemEvent extends NutritionEvent {
  final String uid;
  final String foodCardType;
  final String itemId;

  const FetchAndAddFoodItemEvent(
      {required this.uid, required this.itemId, required this.foodCardType});

  @override
  List<Object> get props => [uid, itemId, foodCardType];
}

class FetchNutrientDataEvent extends NutritionEvent {
  final String uid;

  const FetchNutrientDataEvent({required this.uid});
  @override
  List<Object> get props => [uid];
}

class GetTotalNutritions extends NutritionEvent {
  final String title;
  final String type;

  const GetTotalNutritions({
    required this.title,
    required this.type,
  });

  @override
  List<Object> get props => [title, type];
}

class UpdateWaterConsumedEvent extends NutritionEvent {
  final String waterConsumed;
  const UpdateWaterConsumedEvent({
    required this.waterConsumed,
  });
  @override
  List<Object> get props => [waterConsumed];
}

class UpdateGoalCaloriesEvent extends NutritionEvent {
  final String uid;
  final int goalCalories;

  const UpdateGoalCaloriesEvent({
    required this.uid,
    required this.goalCalories,
  });

  @override
  List<Object> get props => [uid, goalCalories];
}

class UpdateGoalCarbsEvent extends NutritionEvent {
  final String uid;
  final int goalCarbs;
  const UpdateGoalCarbsEvent({
    required this.uid,
    required this.goalCarbs,
  });
  @override
  List<Object> get props => [uid, goalCarbs];
}

class UpdateGoalFatsEvent extends NutritionEvent {
  final String uid;
  final int goalFats;

  const UpdateGoalFatsEvent({
    required this.uid,
    required this.goalFats,
  });

  @override
  List<Object> get props => [uid, goalFats];
}

class UpdateGoalProteinsEvent extends NutritionEvent {
  final String uid;
  final int goalProteins;

  const UpdateGoalProteinsEvent({
    required this.uid,
    required this.goalProteins,
  });

  @override
  List<Object> get props => [uid, goalProteins];
}
