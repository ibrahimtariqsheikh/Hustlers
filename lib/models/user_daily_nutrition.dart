import 'package:equatable/equatable.dart';
import 'package:synew_gym/models/daily_logs.dart';

class UserFoodNutrition extends Equatable {
  final List<DailyLogs> dailyLogs;
  final double totalWater;
  final double totalCalories;
  final double totalCarbs;
  final double totalFat;
  final double totalProtein;
  final double goalCalories;
  final double goalCarbs;
  final double goalFat;
  final double goalProtein;

  const UserFoodNutrition({
    required this.dailyLogs,
    required this.totalWater,
    required this.totalCalories,
    required this.totalCarbs,
    required this.totalFat,
    required this.totalProtein,
    required this.goalCalories,
    required this.goalCarbs,
    required this.goalFat,
    required this.goalProtein,
  });

  factory UserFoodNutrition.initial() {
    return UserFoodNutrition(
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
    );
  }

  factory UserFoodNutrition.fromJson(Map<String, dynamic> json) {
    return UserFoodNutrition(
      dailyLogs: (json['dailyLogs'] as List)
          .map((e) => DailyLogs.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalWater: json['totalWater'],
      totalCalories: json['totalCalories'],
      totalCarbs: json['totalCarbs'],
      totalFat: json['totalFat'],
      totalProtein: json['totalProtein'],
      goalCalories: json['goalCalories'],
      goalCarbs: json['goalCarbs'],
      goalFat: json['goalFat'],
      goalProtein: json['goalProtein'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dailyLogs': dailyLogs.map((e) => e.toJson()).toList(),
      'totalWater': totalWater,
      'totalCalories': totalCalories,
      'totalCarbs': totalCarbs,
      'totalFat': totalFat,
      'totalProtein': totalProtein,
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
    );
  }

  @override
  String toString() {
    return 'UserFoodNutrition(dailyLogs: $dailyLogs, totalWater: $totalWater, totalCalories: $totalCalories, totalCarbs: $totalCarbs, totalFat: $totalFat, totalProtein: $totalProtein, goalCalories: $goalCalories, goalCarbs: $goalCarbs, goalFat: $goalFat, goalProtein: $goalProtein)';
  }

  @override
  List<Object?> get props => [
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
      ];
}
