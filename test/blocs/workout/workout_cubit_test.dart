import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:synew_gym/blocs/profile/cubit/profile_cubit.dart';
import 'package:synew_gym/blocs/workout/cubit/workout_cubit.dart';
import 'package:synew_gym/models/exercise.dart';
import 'package:synew_gym/models/exercises.dart';
import 'package:synew_gym/models/workout.dart';

class MockProfileCubit extends Mock implements ProfileCubit {}

void main() {
  late WorkoutCubit workoutCubit;
  late MockProfileCubit mockProfileCubit;

  setUp(() {
    mockProfileCubit = MockProfileCubit();
    workoutCubit = WorkoutCubit(profileCubit: mockProfileCubit);
  });

  tearDown(() {
    workoutCubit.close();
  });

  group('WorkoutCubit', () {
    Exercise exercise = const Exercise(
        name: 'Exercise 1', isCompleted: false, reps: [], sets: 0, weights: []);
    Workout workout = Workout(
        days: [],
        isSelected: false,
        name: 'Workout',
        exerciseData: [
          ExerciseData(name: 'Day 1', exercises: [exercise]),
          ExerciseData(name: 'Day 2', exercises: []),
        ]);

    test('initial state is correct', () {
      expect(workoutCubit.state, WorkoutState.initial());
    });

    blocTest<WorkoutCubit, WorkoutState>('addEmptyExercise emits correct state',
        build: () => workoutCubit,
        act: (cubit) => cubit.addEmptyExercise(0),
        expect: () => [
              WorkoutState(
                  status: WorkoutStatus.loading,
                  workout: Workout(
                      name: '',
                      days: const [
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false
                      ],
                      exerciseData: [
                        ExerciseData(name: '', exercises: const [
                          Exercise(
                              name: '',
                              sets: 0,
                              reps: [],
                              weights: [],
                              isCompleted: false)
                        ]),
                        ExerciseData(name: '', exercises: []),
                        ExerciseData(name: '', exercises: []),
                        ExerciseData(name: '', exercises: []),
                        ExerciseData(name: '', exercises: []),
                        ExerciseData(
                          name: '',
                          exercises: [],
                        ),
                        ExerciseData(name: '', exercises: [])
                      ],
                      isSelected: false)),
              WorkoutState(
                  status: WorkoutStatus.loaded,
                  workout: Workout(
                      name: '',
                      days: const [
                        false,
                        false,
                        false,
                        false,
                        false,
                        false,
                        false
                      ],
                      exerciseData: [
                        ExerciseData(name: '', exercises: const [
                          Exercise(
                              name: '',
                              reps: [],
                              sets: 0,
                              weights: [],
                              isCompleted: false)
                        ]),
                        ExerciseData(name: '', exercises: []),
                        ExerciseData(name: '', exercises: []),
                        ExerciseData(name: '', exercises: []),
                        ExerciseData(name: '', exercises: []),
                        ExerciseData(name: '', exercises: []),
                        ExerciseData(name: '', exercises: [])
                      ],
                      isSelected: false))
            ]);

    blocTest<WorkoutCubit, WorkoutState>(
        'updateWorkoutName emits correct state',
        build: () => workoutCubit,
        act: (cubit) => cubit.updateWorkoutName('New Workout'),
        expect: () => [
              WorkoutState(
                workout: Workout(days: const [
                  false,
                  false,
                  false,
                  false,
                  false,
                  false,
                  false
                ], exerciseData: [
                  ExerciseData(name: '', exercises: []),
                  ExerciseData(name: '', exercises: []),
                  ExerciseData(name: '', exercises: []),
                  ExerciseData(name: '', exercises: []),
                  ExerciseData(name: '', exercises: []),
                  ExerciseData(name: '', exercises: []),
                  ExerciseData(name: '', exercises: const [])
                ], isSelected: false, name: 'New Workout'),
                status: WorkoutStatus.initial,
              )
            ]);

    blocTest<WorkoutCubit, WorkoutState>(
      'updateWorkoutDayTitle emits correct state',
      build: () => workoutCubit,
      act: (cubit) => cubit.updateWorkoutDayTitle(0, 'New Day Title'),
      expect: () => [
        WorkoutState(
          workout: Workout(days: const [
            false,
            false,
            false,
            false,
            false,
            false,
            false
          ], exerciseData: [
            ExerciseData(name: 'New Day Title', exercises: []),
            ExerciseData(name: '', exercises: []),
            ExerciseData(name: '', exercises: []),
            ExerciseData(name: '', exercises: []),
            ExerciseData(name: '', exercises: []),
            ExerciseData(name: '', exercises: []),
            ExerciseData(name: '', exercises: const [])
          ], isSelected: false, name: ''),
          status: WorkoutStatus.initial,
        )
      ],
    );

    blocTest<WorkoutCubit, WorkoutState>(
      'resetWorkout emits correct state',
      build: () => workoutCubit,
      act: (cubit) => cubit.resetWorkout(),
      expect: () => [
        WorkoutState(
            status: WorkoutStatus.initial,
            workout: Workout(
                name: '',
                days: const [false, false, false, false, false, false, false],
                exerciseData: [
                  ExerciseData(name: '', exercises: []),
                  ExerciseData(name: '', exercises: []),
                  ExerciseData(name: '', exercises: []),
                  ExerciseData(name: '', exercises: []),
                  ExerciseData(name: '', exercises: []),
                  ExerciseData(name: '', exercises: []),
                  ExerciseData(name: '', exercises: [])
                ],
                isSelected: false)),
      ],
    );

    // blocTest<WorkoutCubit, WorkoutState>(
    //   'addWorkoutToFirebase emits correct state and calls profileCubit.addUserWorkout',
    //   build: () => workoutCubit,
    //   act: (cubit) => cubit.addWorkoutToFirebase(),
    //   verify: (_) {
    //     verify(mockProfileCubit.addUserWorkout(workout)).called(1);
    //   },
    //   expect: () => [
    //     // WorkoutState(status: WorkoutStatus.initial, workout: workout),
    //     WorkoutState(status: WorkoutStatus.loaded, workout: Workout.initial()),
    //   ],
    // );
  });
}
