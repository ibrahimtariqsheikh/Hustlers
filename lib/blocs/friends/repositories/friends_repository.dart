import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:synew_gym/constants/db_constants.dart';
import 'package:synew_gym/models/user_model.dart';
import 'package:synew_gym/models/workout.dart';

class FriendsRepository {
  final FirebaseFirestore firebaseFirestore;

  FriendsRepository(this.firebaseFirestore);
  Future<List<User>> searchUserByUsername(String username) async {
    List<User> fetchedUsers = [];

    await usersRef
        .where('username', isEqualTo: username)
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        User user = User.fromJson(docSnapshot.data());
        fetchedUsers.add(user);
      }
    });

    await usersRef
        .orderBy('username')
        .startAt([username])
        .endAt(['$username\uf8ff'])
        .get()
        .then((querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            User user = User.fromJson(docSnapshot.data());
            if (!fetchedUsers.contains(user)) {
              fetchedUsers.add(user);
            }
          }
        });

    return fetchedUsers;
  }

  Future<void> shareWorkout(String friendId, Workout workout) async {
    DocumentReference userDocRef = usersRef.doc(friendId);
    DocumentSnapshot userDoc = await userDocRef.get();

    try {
      if (!userDoc.exists) {
        await userDocRef.set({
          'workouts': [workout.toJson()],
        });
      } else {
        List<dynamic> workouts = userDoc['workouts'] ?? [];
        if (workouts.isEmpty) {
          await userDocRef.update({
            'workouts': FieldValue.arrayUnion([workout.toJson()])
          });
        }
      }
    } catch (e) {
      // print(e);
    }
  }

  Future<void> addFriend(String loggedInUserId, String friendId) async {
    await usersRef.doc(loggedInUserId).update({
      'friends': FieldValue.arrayUnion([friendId]),
    }).catchError((error) {});

    await usersRef.doc(friendId).update({
      'friends': FieldValue.arrayUnion([loggedInUserId]),
    }).catchError((error) {});
  }
}
