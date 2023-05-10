import 'package:equatable/equatable.dart';

import 'package:synew_gym/models/exercises.dart';

class Workout extends Equatable {
  final String name;
  final List<bool> days;
  final List<ExerciseData> exerciseData;
  final bool isSelected;
  const Workout({
    required this.name,
    required this.days,
    required this.exerciseData,
    required this.isSelected,
  });

  factory Workout.initial() {
    return Workout(
      name: '',
      isSelected: false,
      days: const [
        false,
        false,
        false,
        false,
        false,
        false,
        false,
      ],
      exerciseData: [
        ExerciseData.initial(),
        ExerciseData.initial(),
        ExerciseData.initial(),
        ExerciseData.initial(),
        ExerciseData.initial(),
        ExerciseData.initial(),
        ExerciseData.initial(),
      ],
    );
  }

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      name: json['name'],
      days: List<bool>.from(json['days']),
      isSelected: json['isSelected'] ?? false,
      exerciseData: (json['exercises'] as List<dynamic>)
          .map((e) => ExerciseData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'days': days,
      'isSelected': isSelected,
      'exercises': exerciseData.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object> get props => [name, days, exerciseData, isSelected];

  Workout copyWith({
    String? name,
    List<bool>? days,
    bool? isSelected,
    List<ExerciseData>? exerciseData,
  }) {
    return Workout(
      name: name ?? this.name,
      days: days ?? this.days,
      isSelected: isSelected ?? this.isSelected,
      exerciseData: exerciseData ?? this.exerciseData,
    );
  }

  @override
  bool get stringify => true;
}
