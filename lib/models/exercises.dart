import 'package:equatable/equatable.dart';
import 'package:synew_gym/models/exercise.dart';

// ignore: must_be_immutable
class ExerciseData extends Equatable {
  String? name;
  List<Exercise>? exercises;

  factory ExerciseData.initial() {
    return ExerciseData(
      name: '',
      exercises: const [],
    );
  }

  ExerciseData({this.name, this.exercises});

  ExerciseData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['exercises'] != null) {
      exercises = <Exercise>[];
      json['exercises'].forEach((v) {
        exercises!.add(Exercise.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    if (exercises != null) {
      data['exercises'] = exercises!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  ExerciseData copyWith({
    String? name,
    List<Exercise>? exercises,
  }) {
    return ExerciseData(
      name: name ?? this.name,
      exercises: exercises ?? this.exercises,
    );
  }

  @override
  String toString() => 'Exercises(name: $name, exercises: $exercises)';

  @override
  List<Object?> get props => [name, exercises];

  @override
  bool get stringify => true;
}
