import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:synew_gym/constants/db_constants.dart';
import 'package:synew_gym/models/custom_error.dart';
import 'package:synew_gym/models/user_model.dart';

import '../../../models/workout.dart';

class UserRepository {
  final FirebaseFirestore firebaseFirestore;
  final fb_auth.FirebaseAuth firebaseAuth;

  UserRepository(
    this.firebaseFirestore,
    this.firebaseAuth,
  );

  Future<void> updateWorkoutInFirebase(
      String uid, Workout updatedWorkout) async {
    try {
      DocumentReference userDocRef = usersRef.doc(uid);
      DocumentSnapshot userDoc = await userDocRef.get();

      if (userDoc.exists) {
        List<dynamic> currentWorkoutsMaps =
            (userDoc.data() as Map<String, dynamic>)['workouts'] ?? [];

        List<Workout> currentWorkouts = currentWorkoutsMaps
            .map((workoutMap) =>
                Workout.fromJson(workoutMap as Map<String, dynamic>))
            .toList();

        List<Workout> updatedWorkouts = currentWorkouts.map((workout) {
          return workout.name == updatedWorkout.name ? updatedWorkout : workout;
        }).toList();

        List<Map<String, dynamic>> updatedWorkoutsMaps =
            updatedWorkouts.map((workout) => workout.toJson()).toList();

        await userDocRef.update({'workouts': updatedWorkoutsMaps});
      } else {
        throw 'User not found';
      }
    } on fb_auth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<User> fetchProfileData({
    required String uid,
  }) async {
    try {
      final DocumentSnapshot userDoc = await usersRef.doc(uid).get();

      if (userDoc.exists) {
        final currentUser = User.fromDoc(userDoc);
        return currentUser;
      }
      throw 'User not found';
    } on fb_auth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> updateSelectedWorkoutInFirebase(
      String uid, Workout workout) async {
    try {
      DocumentReference userDocRef = usersRef.doc(uid);
      DocumentSnapshot userDoc = await userDocRef.get();

      if (userDoc.exists) {
        List<dynamic> currentWorkoutsMaps =
            (userDoc.data() as Map<String, dynamic>)['workouts'] ?? [];

        List<Workout> currentWorkouts = currentWorkoutsMaps
            .map((workoutMap) =>
                Workout.fromJson(workoutMap as Map<String, dynamic>))
            .toList();

        List<Workout> updatedWorkouts = currentWorkouts.map((w) {
          return w.name == workout.name
              ? w.copyWith(isSelected: workout.isSelected)
              : w;
        }).toList();

        List<Map<String, dynamic>> updatedWorkoutsMaps =
            updatedWorkouts.map((workout) => workout.toJson()).toList();

        await userDocRef.update({'workouts': updatedWorkoutsMaps});
      } else {
        throw 'User not found';
      }
    } on fb_auth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> deleteWorkoutInFirebase(String uid, Workout workout) async {
    try {
      DocumentReference userDocRef = usersRef.doc(uid);
      DocumentSnapshot userDoc = await userDocRef.get();

      if (userDoc.exists) {
        List<dynamic> currentWorkoutsMaps =
            (userDoc.data() as Map<String, dynamic>)['workouts'] ?? [];

        List<Workout> currentWorkouts = currentWorkoutsMaps
            .map((workoutMap) =>
                Workout.fromJson(workoutMap as Map<String, dynamic>))
            .toList();

        currentWorkouts.removeWhere((w) => w.name == workout.name);

        List<Map<String, dynamic>> updatedWorkoutsMaps =
            currentWorkouts.map((workout) => workout.toJson()).toList();

        await userDocRef.update({'workouts': updatedWorkoutsMaps});
      } else {
        throw 'User not found';
      }
    } on fb_auth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> updateUserWorkouts(
    String uid,
    List<Workout> workouts,
  ) async {
    try {
      DocumentReference userDocRef = usersRef.doc(uid);
      DocumentSnapshot userDoc = await userDocRef.get();

      if (userDoc.exists) {
        List<Map<String, dynamic>> updatedWorkoutsMaps =
            workouts.map((workout) => workout.toJson()).toList();

        await userDocRef.update({'workouts': updatedWorkoutsMaps});
      } else {
        throw 'User not found';
      }
    } on fb_auth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> addWorkoutToFirebase(
    String uid,
    Workout workout,
  ) async {
    try {
      DocumentReference userDocRef = usersRef.doc(uid);
      DocumentSnapshot userDoc = await userDocRef.get();

      if (userDoc.exists) {
        List<dynamic> currentWorkoutsMaps =
            (userDoc.data() as Map<String, dynamic>)['workouts'] ?? [];

        List<Workout> currentWorkouts = currentWorkoutsMaps
            .map((workoutMap) =>
                Workout.fromJson(workoutMap as Map<String, dynamic>))
            .toList();

        currentWorkouts.add(workout);

        List<Map<String, dynamic>> updatedWorkoutsMaps =
            currentWorkouts.map((workout) => workout.toJson()).toList();

        await userDocRef.update({'workouts': updatedWorkoutsMaps});
      } else {
        throw 'User not found';
      }
    } on fb_auth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  Future<void> updateUserWorkoutInFirebase(
      String uid, Workout updatedWorkout) async {
    try {
      DocumentReference userDocRef = usersRef.doc(uid);
      DocumentSnapshot userDoc = await userDocRef.get();

      if (userDoc.exists) {
        List<dynamic> currentWorkoutsMaps =
            (userDoc.data() as Map<String, dynamic>)['workouts'] ?? [];

        List<Workout> currentWorkouts = currentWorkoutsMaps
            .map((workoutMap) =>
                Workout.fromJson(workoutMap as Map<String, dynamic>))
            .toList();

        List<Workout> updatedWorkouts = currentWorkouts
            .map((workout) =>
                workout.name == updatedWorkout.name ? updatedWorkout : workout)
            .toList();

        List<Map<String, dynamic>> updatedWorkoutsMaps =
            updatedWorkouts.map((workout) => workout.toJson()).toList();

        await userDocRef.update({'workouts': updatedWorkoutsMaps});
      } else {
        throw 'User not found';
      }
    } on fb_auth.FirebaseAuthException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }
}
