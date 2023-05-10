part of 'nutrition_bloc.dart';

enum NutririonStatus {
  initial,
  loading,
  loaded,
  error,
}

class NutritionState extends Equatable {
  final NutririonStatus nutririonStatus;
  final List<Food> foodItems;
  final UserFoodNutrition userFoodNutrition;
  final CustomError error;

  const NutritionState({
    required this.nutririonStatus,
    required this.foodItems,
    required this.userFoodNutrition,
    required this.error,
  });

  factory NutritionState.initial() {
    return NutritionState(
      nutririonStatus: NutririonStatus.initial,
      foodItems: const [],
      userFoodNutrition: UserFoodNutrition.initial(),
      error: const CustomError(),
    );
  }

  @override
  List<Object> get props => [
        nutririonStatus,
        foodItems,
        userFoodNutrition,
        error,
      ];

  NutritionState copyWith({
    NutririonStatus? nutririonStatus,
    List<Food>? foodItems,
    UserFoodNutrition? userFoodNutrition,
    CustomError? error,
  }) {
    return NutritionState(
      nutririonStatus: nutririonStatus ?? this.nutririonStatus,
      foodItems: foodItems ?? this.foodItems,
      userFoodNutrition: userFoodNutrition ?? this.userFoodNutrition,
      error: error ?? this.error,
    );
  }

  @override
  bool get stringify => true;
}
