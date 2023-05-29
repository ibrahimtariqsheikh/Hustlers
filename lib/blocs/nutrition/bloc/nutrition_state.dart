part of 'nutrition_bloc.dart';

enum NutririonStatus {
  initial,
  loading,
  loaded,
  error,
}

// ignore: must_be_immutable
class NutritionState extends Equatable {
  final NutririonStatus nutririonStatus;
  final List<Food> foodItems;
  final UserFoodNutrition userFoodNutrition;
  final CustomError error;
  String selectedDate;

  NutritionState({
    required this.nutririonStatus,
    required this.foodItems,
    required this.userFoodNutrition,
    required this.error,
    required this.selectedDate,
  });

  factory NutritionState.initial() {
    return NutritionState(
      nutririonStatus: NutririonStatus.initial,
      foodItems: const [],
      userFoodNutrition: UserFoodNutrition.initial(),
      error: const CustomError(),
      selectedDate:
          '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
    );
  }

  @override
  List<Object> get props =>
      [nutririonStatus, foodItems, userFoodNutrition, error, selectedDate];

  NutritionState copyWith({
    NutririonStatus? nutririonStatus,
    List<Food>? foodItems,
    UserFoodNutrition? userFoodNutrition,
    CustomError? error,
    String? selectedDate,
  }) {
    return NutritionState(
        nutririonStatus: nutririonStatus ?? this.nutririonStatus,
        foodItems: foodItems ?? this.foodItems,
        userFoodNutrition: userFoodNutrition ?? this.userFoodNutrition,
        error: error ?? this.error,
        selectedDate: selectedDate ?? this.selectedDate);
  }

  @override
  bool get stringify => true;
}
