import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:synew_gym/helpers.dart';
import 'package:synew_gym/models/workout.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String firstname;
  final String lastname;
  final String gender;
  final String email;
  final String? bio;
  final DateTime lastMessageTime;
  final List<String>? followers;
  final List<String>? following;
  final List<Workout>? workouts;

  const User({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.gender,
    required this.email,
    required this.lastMessageTime,
    this.bio,
    this.followers,
    this.following,
    this.workouts,
  });

  factory User.fromDoc(DocumentSnapshot userDoc) {
    final userData = userDoc.data() as Map<String, dynamic>?;

    return User(
      id: userData!['id'],
      username: userData['username'],
      firstname: userData['firstname'],
      lastname: userData['lastname'],
      gender: userData['gender'],
      email: userData['email'],
      bio: userData['bio'],
      lastMessageTime:
          Helpers.toDateTime(userData['lastMessageTime'] as Timestamp),
      followers: List<String>.from(userData['followers'] as List<dynamic>),
      following: List<String>.from(userData['following'] as List<dynamic>),
      workouts: (userData['workouts'] as List<dynamic>?)
          ?.map((workoutMap) =>
              Workout.fromJson(workoutMap as Map<String, dynamic>))
          .toList(),
    );
  }

  factory User.initial() {
    return User(
      id: '',
      username: '',
      firstname: '',
      lastname: '',
      gender: '',
      email: '',
      bio: '',
      lastMessageTime: DateTime.now(),
      followers: const [],
      following: const [],
      workouts: const [],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "gender": gender,
        "email": email,
        "bio": bio,
        "lastMessageTime": Helpers.fromDateTimeToJson(lastMessageTime),
        "followers": followers,
        "following": following,
        "workouts": workouts?.map((workout) => workout.toJson()).toList(),
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      username,
      firstname,
      lastname,
      gender,
      email,
      bio,
      lastMessageTime,
      followers,
      following,
      workouts,
    ];
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      gender: json['gender'],
      email: json['email'],
      bio: json['bio'],
      lastMessageTime: Helpers.toDateTime(json['lastMessageTime'] as Timestamp),
      followers: List<String>.from(json['followers'] as List<dynamic>),
      following: List<String>.from(json['following'] as List<dynamic>),
      workouts: (json['workouts'] as List<dynamic>?)
          ?.map((workoutMap) =>
              Workout.fromJson(workoutMap as Map<String, dynamic>))
          .toList(),
    );
  }

  User copyWith({
    String? id,
    String? username,
    String? firstname,
    String? lastname,
    String? gender,
    String? email,
    String? bio,
    DateTime? lastMessageTime,
    List<String>? followers,
    List<String>? following,
    List<Workout>? workouts,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      workouts: workouts ?? this.workouts,
    );
  }
}
