// workout_cubit.dart
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:synew_gym/blocs/profile/profile_cubit.dart';
import 'package:synew_gym/models/exercise.dart';
import 'package:synew_gym/models/exercises.dart';
import 'package:synew_gym/models/workout.dart';

part 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  final ProfileCubit profileCubit;

  WorkoutCubit({
    required this.profileCubit,
  }) : super(WorkoutState.initial());

  void addEmptyExercise(int dayIndex) {
    emit(state.copyWith(status: WorkoutStatus.loading));
    Workout workout = addExercise(dayIndex, Exercise.initial());
    emit(state.copyWith(workout: workout, status: WorkoutStatus.loaded));
  }

  void updateWorkoutName(String name) {
    final updatedWorkout = state.workout.copyWith(name: name);
    emit(state.copyWith(workout: updatedWorkout));
  }

  void updateWorkoutDayTitle(int workoutIndex, String title) {
    final updatedExercises =
        List<ExerciseData>.from(state.workout.exerciseData);
    updatedExercises[workoutIndex] =
        updatedExercises[workoutIndex].copyWith(name: title);

    final updatedWorkout =
        state.workout.copyWith(exerciseData: updatedExercises);

    emit(state.copyWith(workout: updatedWorkout));
  }

  void updateExerciseName(
      int workoutIndex, int exerciseIndex, String workoutName) {
    final updatedExercises =
        List<ExerciseData>.from(state.workout.exerciseData);
    updatedExercises[workoutIndex].exercises![exerciseIndex] =
        updatedExercises[workoutIndex]
            .exercises![exerciseIndex]
            .copyWith(name: workoutName);
    final updatedWorkout =
        state.workout.copyWith(exerciseData: updatedExercises);
    emit(state.copyWith(workout: updatedWorkout));
  }

  void updateExerciseSets(int workoutIndex, int exerciseIndex, String sets) {
    if (sets != '') {
      final int setsCount = int.parse(sets);

      List<int> updatedWeights = List.filled(setsCount, 0);
      List<int> updatedReps = List.filled(setsCount, 0);

      final updatedExercises =
          List<ExerciseData>.from(state.workout.exerciseData);
      updatedExercises[workoutIndex].exercises![exerciseIndex] =
          updatedExercises[workoutIndex].exercises![exerciseIndex].copyWith(
              sets: setsCount, weights: updatedWeights, reps: updatedReps);
      final updatedWorkout =
          state.workout.copyWith(exerciseData: updatedExercises);
      emit(state.copyWith(workout: updatedWorkout));
    }
  }

  void updateExerciseReps(
      int workoutIndex, int exerciseIndex, String repsPerSet) {
    if (repsPerSet != '') {
      List<int> newRepsList = repsPerSet
          .split(',')
          .where((rep) => rep.trim().isNotEmpty)
          .map((rep) => int.parse(rep))
          .toList();

      final updatedExercises =
          List<ExerciseData>.from(state.workout.exerciseData);

      List<int> currentRepsList =
          updatedExercises[workoutIndex].exercises![exerciseIndex].reps;

      int minLength = min(newRepsList.length, currentRepsList.length);
      for (int i = 0; i < minLength; i++) {
        currentRepsList[i] = newRepsList[i];
      }

      if (newRepsList.length == 1 && currentRepsList.length > 1) {
        currentRepsList[0] = newRepsList[0];
        currentRepsList[1] = 0;
      }

      updatedExercises[workoutIndex].exercises![exerciseIndex] =
          updatedExercises[workoutIndex]
              .exercises![exerciseIndex]
              .copyWith(reps: currentRepsList);
      final updatedWorkout =
          state.workout.copyWith(exerciseData: updatedExercises);
      emit(state.copyWith(workout: updatedWorkout));
    }
  }

  void updateDay(int dayIndex, bool value) {
    final updatedDays = List<bool>.from(state.workout.days)..[dayIndex] = value;
    final updatedWorkout = state.workout.copyWith(days: updatedDays);
    emit(state.copyWith(workout: updatedWorkout));
  }

  Workout addExercise(int dayIndex, Exercise exercise) {
    final updatedExercises =
        List<ExerciseData>.from(state.workout.exerciseData);

    List<Exercise> exercisesList =
        List<Exercise>.from(updatedExercises[dayIndex].exercises!);
    exercisesList.add(exercise);
    updatedExercises[dayIndex].exercises = exercisesList;

    final updatedWorkout =
        state.workout.copyWith(exerciseData: updatedExercises);

    return updatedWorkout;
  }

  void addWorkoutToFirebase() async {
    emit(state.copyWith(status: WorkoutStatus.loading));
    final workout = state.workout;

    await profileCubit.addUserWorkout(workout);
    emit(state.copyWith(status: WorkoutStatus.loaded));
  }
}
