import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:synew_gym/models/workout.dart';

abstract class Helpers {
  static Workout? findSelectedWorkout(List<Workout> workouts) {
    for (Workout workout in workouts) {
      if (workout.isSelected == true) {
        return workout;
      }
    }
    return null;
  }

  static int findSelectedWorkoutIndex(List<Workout> workouts) {
    int index = 0;
    for (Workout workout in workouts) {
      if (workout.isSelected == true) {
        return index;
      }
      index++;
    }
    return -1;
  }

  static final List<String> days = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  static final List<String> daysFull = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  static final random = Random();

  static String randomPictureUrl() {
    final randomInt = random.nextInt(1000);
    return 'https://picsum.photos/seed/$randomInt/300/300';
  }

  static DateTime randomDate() {
    final random = Random();
    final currentDate = DateTime.now();
    return currentDate.subtract(Duration(seconds: random.nextInt(200000)));
  }

  static StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>>
      transformer<T>(T Function(Map<String, dynamic>) fromJson) =>
          StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
              List<T>>.fromHandlers(
            handleData: (QuerySnapshot<Map<String, dynamic>> data,
                EventSink<List<T>> sink) {
              final snaps = data.docs.map((doc) => doc.data()).toList();
              final users = snaps.map((json) => fromJson(json)).toList();

              sink.add(users);
            },
          );

  static DateTime toDateTime(Timestamp value) {
    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime date) {
    return date.toUtc();
  }
}
