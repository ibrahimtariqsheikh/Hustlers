import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:synew_gym/models/user_model.dart';

final usersRef = FirebaseFirestore.instance.collection('users');
final workoutsRef = FirebaseFirestore.instance.collection('workouts');
final nutrientsRef = FirebaseFirestore.instance.collection('nutrients');

final userSearchRef =
    FirebaseFirestore.instance.collection('users').withConverter<User>(
          fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
          toFirestore: (movie, _) => movie.toJson(),
        );
