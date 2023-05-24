import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:synew_gym/constants/helpers.dart';
import 'package:synew_gym/models/message_data.dart';
import 'package:synew_gym/models/user_model.dart';

class MessageRepository {
  final FirebaseFirestore firebaseFirestore;

  MessageRepository(this.firebaseFirestore);

  Stream<List<User>> get availableUsers => FirebaseFirestore.instance
      .collection('users')
      .orderBy('lastMessageTime', descending: true)
      .snapshots()
      .transform(Helpers.transformer(User.fromJson));

  Stream<List<MessageData>> getMessages(String senderID, String recieverID) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> sentMessages =
        FirebaseFirestore.instance
            .collection('chats')
            .doc(senderID)
            .collection('messages')
            .where("senderID", isEqualTo: senderID)
            .where("recieverID", isEqualTo: recieverID)
            .orderBy("createdAt", descending: true)
            .snapshots();

    final Stream<QuerySnapshot<Map<String, dynamic>>> receivedMessages =
        FirebaseFirestore.instance
            .collection('chats')
            .doc(senderID)
            .collection('messages')
            .where("senderID", isEqualTo: recieverID)
            .where("recieverID", isEqualTo: senderID)
            .orderBy("createdAt", descending: true)
            .snapshots();

    return Rx.combineLatest2<QuerySnapshot<Map<String, dynamic>>,
        QuerySnapshot<Map<String, dynamic>>, List<MessageData>>(
      sentMessages,
      receivedMessages,
      (QuerySnapshot<Map<String, dynamic>> sent,
          QuerySnapshot<Map<String, dynamic>> received) {
        final List<MessageData> allMessages = [
          ...sent.docs.map((doc) => MessageData.fromJson(doc.data())).toList(),
          ...received.docs
              .map((doc) => MessageData.fromJson(doc.data()))
              .toList(),
        ];
        allMessages.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        return allMessages;
      },
    );
  }

  Future uploadMessage(
      String senderID, String recieverID, String message) async {
    final refSenderMessages =
        FirebaseFirestore.instance.collection('chats/$senderID/messages');
    final refRecieverMessages =
        FirebaseFirestore.instance.collection('chats/$recieverID/messages');

    final newMessage = MessageData(
      senderID: senderID,
      recieverID: recieverID,
      urlAvatar: "",
      username: "",
      message: message,
      createdAt: DateTime.now(),
    );
    await refSenderMessages.add(newMessage.toJson());
    await refRecieverMessages.add(newMessage.toJson());

    final refUsers = FirebaseFirestore.instance.collection('users');
    await refUsers.doc(senderID).update({'lastMessageTime': DateTime.now()});
    await refUsers.doc(recieverID).update({'lastMessageTime': DateTime.now()});
  }
}
