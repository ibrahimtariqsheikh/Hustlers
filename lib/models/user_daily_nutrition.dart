import 'package:equatable/equatable.dart';
import 'package:synew_gym/models/daily_logs.dart';

class UserFoodNutrition extends Equatable {
  final List<DailyLogs> dailyLogs;
  final String date;
  final double totalWater;
  final double totalCalories;
  final double totalCarbs;
  final double totalFat;
  final double totalProtein;
  final double goalCalories;
  final double goalCarbs;
  final double goalFat;
  final double goalProtein;
  final double goalWater;

  const UserFoodNutrition(
      {required this.dailyLogs,
      required this.date,
      required this.totalWater,
      required this.totalCalories,
      required this.totalCarbs,
      required this.totalFat,
      required this.totalProtein,
      required this.goalCalories,
      required this.goalCarbs,
      required this.goalFat,
      required this.goalProtein,
      required this.goalWater});

  factory UserFoodNutrition.initial() {
    return UserFoodNutrition(
      date:
          '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
      dailyLogs: DailyLogs.initial(),
      totalWater: 0,
      totalCalories: 0,
      totalCarbs: 0,
      totalFat: 0,
      totalProtein: 0,
      goalCalories: 2000,
      goalCarbs: 200,
      goalFat: 100,
      goalProtein: 200,
      goalWater: 500,
    );
  }

  factory UserFoodNutrition.fromJson(Map<String, dynamic> json) {
    return UserFoodNutrition(
      date: json['date'],
      dailyLogs: (json['dailyLogs'] as List)
          .map((e) => DailyLogs.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCalories: json['totalCalories'],
      totalCarbs: json['totalCarbs'],
      totalFat: json['totalFat'],
      totalProtein: json['totalProtein'],
      goalWater: json['goalWater'],
      goalCalories: json['goalCalories'],
      goalCarbs: json['goalCarbs'],
      goalFat: json['goalFat'],
      goalProtein: json['goalProtein'],
      totalWater: json['totalWater'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'dailyLogs': dailyLogs.map((e) => e.toJson()).toList(),
      'totalWater': totalWater,
      'totalCalories': totalCalories,
      'totalCarbs': totalCarbs,
      'totalFat': totalFat,
      'totalProtein': totalProtein,
      'goalWater': goalWater,
      'goalCalories': goalCalories,
      'goalCarbs': goalCarbs,
      'goalFat': goalFat,
      'goalProtein': goalProtein,
    };
  }

  UserFoodNutrition copyWith({
    List<DailyLogs>? dailyLogs,
    double? totalWater,
    double? totalCalories,
    double? totalCarbs,
    double? totalFat,
    double? totalProtein,
    double? goalCalories,
    double? goalCarbs,
    double? goalFat,
    double? goalProtein,
    double? goalWater,
    String? date,
  }) {
    return UserFoodNutrition(
        dailyLogs: dailyLogs ?? this.dailyLogs,
        totalWater: totalWater ?? this.totalWater,
        totalCalories: totalCalories ?? this.totalCalories,
        totalCarbs: totalCarbs ?? this.totalCarbs,
        totalFat: totalFat ?? this.totalFat,
        totalProtein: totalProtein ?? this.totalProtein,
        goalCalories: goalCalories ?? this.goalCalories,
        goalCarbs: goalCarbs ?? this.goalCarbs,
        goalFat: goalFat ?? this.goalFat,
        goalProtein: goalProtein ?? this.goalProtein,
        goalWater: goalWater ?? this.goalWater,
        date: date ?? this.date);
  }

  @override
  String toString() {
    return 'UserFoodNutrition(date : $date dailyLogs: $dailyLogs, totalWater: $totalWater, totalCalories: $totalCalories, totalCarbs: $totalCarbs, totalFat: $totalFat, totalProtein: $totalProtein, goalCalories: $goalCalories, goalCarbs: $goalCarbs, goalFat: $goalFat, goalProtein: $goalProtein, goalWater: $goalWater)';
  }

  @override
  List<Object?> get props => [
        date,
        dailyLogs,
        totalWater,
        totalCalories,
        totalCarbs,
        totalFat,
        totalProtein,
        goalCalories,
        goalCarbs,
        goalFat,
        goalProtein,
        goalWater
      ];
}
