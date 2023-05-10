// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:synew_gym/models/food.dart';

class DailyLogs extends Equatable {
  final String type;
  final double totalCarbs;
  final double totalFat;
  final double totalProtein;
  final double totalCalories;
  final List<Food> foodList;

  const DailyLogs({
    required this.type,
    required this.foodList,
    required this.totalCarbs,
    required this.totalFat,
    required this.totalProtein,
    required this.totalCalories,
  });

  static List<DailyLogs> initial() {
    return const [
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
    ];
  }

  factory DailyLogs.fromJson(Map<String, dynamic> json) {
    return DailyLogs(
      type: json['type'] ?? '',
      totalCarbs: json['totalCarbs'] ?? 0,
      totalFat: json['totalFat'] ?? 0,
      totalProtein: json['totalProtein'] ?? 0,
      totalCalories: json['totalProtein'] ?? 0,
      foodList: (json['foodList'] as List<dynamic>?)
              ?.map((item) => Food.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'totalCarbs': totalCarbs,
      'totalFat': totalFat,
      'totalProtein': totalProtein,
      'foodList': foodList.map((item) => item.toJson()).toList(),
    };
  }

  DailyLogs copyWith({
    String? type,
    double? totalCarbs,
    double? totalFat,
    double? totalProtein,
    double? totalCalories,
    List<Food>? foodList,
  }) {
    return DailyLogs(
      type: type ?? this.type,
      totalCarbs: totalCarbs ?? this.totalCarbs,
      totalFat: totalFat ?? this.totalFat,
      totalProtein: totalProtein ?? this.totalProtein,
      totalCalories: totalCalories ?? this.totalCalories,
      foodList: foodList ?? this.foodList,
    );
  }

  @override
  String toString() => 'DailyLogs(type: $type, foodList: $foodList)';

  @override
  List<Object?> get props =>
      [type, foodList, totalCarbs, totalFat, totalProtein, totalCalories];
}
