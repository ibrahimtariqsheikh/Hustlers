import 'package:cloud_firestore/cloud_firestore.dart';

final usersRef = FirebaseFirestore.instance.collection('users');
final workoutsRef = FirebaseFirestore.instance.collection('workouts');
final nutrientsRef = FirebaseFirestore.instance.collection('nutrients');
