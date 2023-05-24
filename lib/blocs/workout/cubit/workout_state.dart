part of 'workout_cubit.dart';

enum WorkoutStatus { initial, loading, loaded }

class WorkoutState extends Equatable {
  final WorkoutStatus status;
  final Workout workout;

  const WorkoutState({
    required this.status,
    required this.workout,
  });

  factory WorkoutState.initial() {
    return WorkoutState(
      status: WorkoutStatus.initial,
      workout: Workout.initial(),
    );
  }

  @override
  List<Object> get props => [status, workout];

  WorkoutState copyWith({
    WorkoutStatus? status,
    Workout? workout,
  }) {
    return WorkoutState(
      status: status ?? this.status,
      workout: workout ?? this.workout,
    );
  }
}
