// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Exercise extends Equatable {
  final String name;
  final int sets;
  final List<int> reps;
  final List<int> weights;

  final bool isCompleted;
  const Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.weights,
    required this.isCompleted,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      weights: json['weights'].cast<int>(),
      reps: json['reps'].cast<int>(),
      sets: json['sets'],
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': name,
      'weights': weights,
      'reps': reps,
      'sets': sets,
      'isCompleted': isCompleted,
    };
    return data;
  }

  @override
  List<Object> get props {
    return [
      name,
      sets,
      reps,
      weights,
      isCompleted,
    ];
  }

  factory Exercise.initial() {
    return const Exercise(
        name: '', weights: [], sets: 0, reps: [], isCompleted: false);
  }

  Exercise copyWith({
    String? name,
    int? sets,
    List<int>? reps,
    List<int>? weights,
    bool? isCompleted,
  }) {
    return Exercise(
      name: name ?? this.name,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      weights: weights ?? this.weights,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  bool get stringify => true;
}
