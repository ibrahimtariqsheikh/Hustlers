import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:synew_gym/blocs/nutrition/bloc/nutrition_bloc.dart';
import 'package:synew_gym/blocs/nutrition/repository/nutrition_repository.dart';
import 'package:synew_gym/models/custom_error.dart';
import 'package:synew_gym/models/daily_logs.dart';
import 'package:synew_gym/models/user_daily_nutrition.dart';

class MockNutritionRepository extends Mock implements NutritionRepository {}

@GenerateMocks([MockNutritionRepository])
void main() {
  group('NutritionBloc', () {
    late NutritionBloc nutritionBloc;
    late MockNutritionRepository nutritionRepository;

    setUp(() {
      nutritionRepository = MockNutritionRepository();
      nutritionBloc = NutritionBloc(nutritionRepository: nutritionRepository);
    });
    test('Initial state is correct', () {
      expect(nutritionBloc.state, NutritionState.initial());
    });

    blocTest<NutritionBloc, NutritionState>(
      'emits [loading, loaded] when FetchNutrientDataEvent success',
      build: () {
        when(nutritionRepository.fetchUserNutrientsData('', ''))
            .thenAnswer((_) async => UserFoodNutrition.initial());
        return nutritionBloc;
      },
      act: (bloc) => bloc.add(const FetchNutrientDataEvent(uid: '')),
      expect: () => <NutritionState>[
        NutritionState(
            foodItems: [],
            selectedDate: '',
            error: const CustomError(code: '', message: '', plugin: ''),
            nutririonStatus: NutririonStatus.loading,
            userFoodNutrition: const UserFoodNutrition(
              dailyLogs: [
                DailyLogs(
                    type: 'breakfast',
                    foodList: [],
                    totalCarbs: 0,
                    totalFat: 0,
                    totalProtein: 0,
                    totalCalories: 0),
                DailyLogs(
                    type: 'lunch',
                    foodList: [],
                    totalCarbs: 0,
                    totalFat: 0,
                    totalProtein: 0,
                    totalCalories: 0),
                DailyLogs(
                    type: 'dinner',
                    foodList: [],
                    totalCarbs: 0,
                    totalFat: 0,
                    totalProtein: 0,
                    totalCalories: 0),
                DailyLogs(
                    type: 'snacks',
                    foodList: [],
                    totalCarbs: 0,
                    totalFat: 0,
                    totalProtein: 0,
                    totalCalories: 0),
              ],
              date: '',
              goalCalories: 0,
              goalCarbs: 0,
              goalFat: 0,
              goalProtein: 0,
              goalWater: 0,
              totalCalories: 0,
              totalCarbs: 0,
              totalFat: 0,
              totalProtein: 0,
              totalWater: 0,
            )),
        NutritionState(
            foodItems: [],
            selectedDate: '',
            error: const CustomError(code: '', message: '', plugin: ''),
            nutririonStatus: NutririonStatus.loaded,
            userFoodNutrition: const UserFoodNutrition(
              dailyLogs: [
                DailyLogs(
                    type: 'breakfast',
                    foodList: [],
                    totalCarbs: 0,
                    totalFat: 0,
                    totalProtein: 0,
                    totalCalories: 0),
                DailyLogs(
                    type: 'lunch',
                    foodList: [],
                    totalCarbs: 0,
                    totalFat: 0,
                    totalProtein: 0,
                    totalCalories: 0),
                DailyLogs(
                    type: 'dinner',
                    foodList: [],
                    totalCarbs: 0,
                    totalFat: 0,
                    totalProtein: 0,
                    totalCalories: 0),
                DailyLogs(
                    type: 'snacks',
                    foodList: [],
                    totalCarbs: 0,
                    totalFat: 0,
                    totalProtein: 0,
                    totalCalories: 0),
              ],
              date: '',
              goalCalories: 0,
              goalCarbs: 0,
              goalFat: 0,
              goalProtein: 0,
              goalWater: 0,
              totalCalories: 0,
              totalCarbs: 0,
              totalFat: 0,
              totalProtein: 0,
              totalWater: 0,
            )),
      ],
    );

    blocTest<NutritionBloc, NutritionState>(
      'emits [loading, error] when FetchNutrientDataEvent failure',
      build: () {
        when(nutritionRepository.fetchUserNutrientsData('', ''))
            .thenThrow(Exception());
        return nutritionBloc;
      },
      act: (bloc) => bloc.add(const FetchNutrientDataEvent(uid: '')),
      expect: () => <NutritionState>[
        NutritionState(
            foodItems: [],
            selectedDate: '',
            error: const CustomError(code: '', message: '', plugin: ''),
            nutririonStatus: NutririonStatus.loading,
            userFoodNutrition: const UserFoodNutrition(
              dailyLogs: [],
              date: '',
              goalCalories: 0,
              goalCarbs: 0,
              goalFat: 0,
              goalProtein: 0,
              goalWater: 0,
              totalCalories: 0,
              totalCarbs: 0,
              totalFat: 0,
              totalProtein: 0,
              totalWater: 0,
            )),
        NutritionState(
            foodItems: [],
            selectedDate: '',
            error: const CustomError(code: '', message: '', plugin: ''),
            nutririonStatus: NutririonStatus.error,
            userFoodNutrition: const UserFoodNutrition(
              dailyLogs: [],
              date: '',
              goalCalories: 0,
              goalCarbs: 0,
              goalFat: 0,
              goalProtein: 0,
              goalWater: 0,
              totalCalories: 0,
              totalCarbs: 0,
              totalFat: 0,
              totalProtein: 0,
              totalWater: 0,
            )),
      ],
    );

    tearDown(() {
      nutritionBloc.close();
    });
  });
}
