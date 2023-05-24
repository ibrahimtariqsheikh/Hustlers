// profile_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health/health.dart';
import 'package:synew_gym/models/custom_error.dart';
import 'package:synew_gym/models/exercises.dart';
import 'package:synew_gym/models/health_data.dart';
import 'package:synew_gym/models/user_model.dart';
import 'package:synew_gym/models/workout.dart';
import 'package:synew_gym/blocs/profile/repository/user_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository profileRepository;
  final HealthFactory _health = HealthFactory();
  late List<HealthDataType> _types;
  ProfileCubit({required this.profileRepository})
      : super(ProfileState.initial());

  Future<void> getUserDetails({required String uid}) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final User user = await profileRepository.fetchProfileData(uid: uid);
      HealthData healthData = await fetchHealthData();
      emit(state.copyWith(
          status: ProfileStatus.loaded, user: user, healthData: healthData));
    } on CustomError catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  void updateExerciseWeight(int workoutIndex, int exerciseIndex, int dayIndex,
      int weightIndex, int weight) async {
    if (state.status == ProfileStatus.loaded) {
      User user = state.user;
      List<Workout> updatedWorkouts =
          List<Workout>.from(state.user.workouts as Iterable);

      Workout workoutToUpdate = updatedWorkouts[workoutIndex];

      List<ExerciseData> updatedExercises =
          List<ExerciseData>.from(workoutToUpdate.exerciseData);

      updatedExercises[dayIndex]
          .exercises![exerciseIndex]
          .weights[weightIndex] = weight;

      Workout updatedWorkout =
          workoutToUpdate.copyWith(exerciseData: updatedExercises);

      updatedWorkouts[workoutIndex] = updatedWorkout;

      User updatedUser = state.user.copyWith(workouts: updatedWorkouts);

      emit(state.copyWith(user: updatedUser));
      await profileRepository.updateWorkoutInFirebase(user.id, updatedWorkout);
    }
  }

  Future<HealthData> fetchHealthData() async {
    _types = [
      HealthDataType.HEART_RATE,
      HealthDataType.SLEEP_IN_BED,
      HealthDataType.STEPS,
      HealthDataType.DISTANCE_WALKING_RUNNING,
    ];

    DateTime startDate = DateTime.now().subtract(const Duration(days: 1000));
    DateTime endDate = DateTime.now();

    bool isAuthorized = false;
    //await _health.requestAuthorization(_types);

    if (isAuthorized) {
      List<HealthDataPoint> healthDataPoints =
          await _health.getHealthDataFromTypes(startDate, endDate, _types);

      List<HealthDataPoint> heartRateDataPoints =
          healthDataPoints.where((p) => p.type == _types[0]).toList();
      List<HealthDataPoint> sleepInBedDataPoints =
          healthDataPoints.where((p) => p.type == _types[1]).toList();
      List<HealthDataPoint> stepsDataPoints =
          healthDataPoints.where((p) => p.type == _types[2]).toList();
      List<HealthDataPoint> distanceWalkingDataPoints =
          healthDataPoints.where((p) => p.type == _types[3]).toList();

      HealthDataPoint? latestHeartRateDataPoint =
          heartRateDataPoints.isNotEmpty ? heartRateDataPoints.last : null;
      HealthDataPoint? latestSleepInBedDataPoint =
          sleepInBedDataPoints.isNotEmpty ? sleepInBedDataPoints.last : null;
      HealthDataPoint? latestStepsDataPoint =
          stepsDataPoints.isNotEmpty ? stepsDataPoints.last : null;
      HealthDataPoint? latestDistanceWalkingDataPoint =
          distanceWalkingDataPoints.isNotEmpty
              ? distanceWalkingDataPoints.last
              : null;

      HealthData healthData = HealthData(
        heartRate: latestHeartRateDataPoint != null
            ? latestHeartRateDataPoint.value.toString()
            : 'N/A',
        sleepInBed: latestSleepInBedDataPoint != null
            ? latestSleepInBedDataPoint.value.toString()
            : 'N/A',
        steps: latestStepsDataPoint != null
            ? latestStepsDataPoint.value.toString()
            : 'N/A',
        distanceWalking: latestDistanceWalkingDataPoint != null
            ? latestDistanceWalkingDataPoint.value.toString()
            : 'N/A',
      );
      return healthData;
    }
    return HealthData.initial();
  }

  Future<void> addWorkout(Workout workout) async {
    if (state.status == ProfileStatus.loaded) {
      User user = state.user;

      List<Workout> updatedWorkouts =
          List<Workout>.from(user.workouts as Iterable)..add(workout);

      user = user.copyWith(workouts: updatedWorkouts);
      emit(state.copyWith(user: user));
      await profileRepository.addWorkoutToFirebase(user.id, workout);
    }
  }

  Future<void> deleteWorkout(Workout workout) async {
    if (state.status == ProfileStatus.loaded) {
      User user = state.user;

      List<Workout> updatedWorkouts =
          List<Workout>.from(user.workouts as Iterable)
            ..removeWhere((currWorkout) => currWorkout.name == workout.name);

      user = user.copyWith(workouts: updatedWorkouts);
      emit(state.copyWith(user: user));
      await profileRepository.deleteWorkoutInFirebase(user.id, workout);
    }
  }

  void selectWorkoutAsMain(Workout selectedWorkout) async {
    final userWorkouts = state.user.workouts;

    List<Workout> updatedWorkouts = [];

    for (var workout in userWorkouts!) {
      if (selectedWorkout.name == workout.name) {
        updatedWorkouts.add(workout.copyWith(isSelected: true));
      } else {
        updatedWorkouts.add(workout.copyWith(isSelected: false));
      }
    }

    User updatedUser = state.user.copyWith(workouts: updatedWorkouts);

    emit(state.copyWith(user: updatedUser));
    await profileRepository.updateUserWorkouts(updatedUser.id, updatedWorkouts);
  }

  addUserWorkout(Workout updatedWorkout) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    User user = state.user;
    List<Workout>? updatedWorkouts = state.user.workouts;
    updatedWorkouts?.add(updatedWorkout);

    user = user.copyWith(workouts: updatedWorkouts);
    emit(state.copyWith(user: user, status: ProfileStatus.loaded));
    await profileRepository.addWorkoutToFirebase(user.id, updatedWorkout);
  }
}
