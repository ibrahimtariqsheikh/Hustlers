part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class GetUserEvent extends ChatEvent {
  final List<User> users;
  const GetUserEvent({required this.users});

  @override
  List<Object?> get props => [users];
}

class SelectChatEvent extends ChatEvent {
  final String senderID;
  final String receiverID;
  const SelectChatEvent({
    required this.senderID,
    required this.receiverID,
  });

  @override
  List<Object?> get props => [senderID, receiverID];
}

class UpdateMessagesEvent extends ChatEvent {
  final List<MessageData> messages;
  const UpdateMessagesEvent({
    required this.messages,
  });

  @override
  List<Object?> get props => [messages];
}

class UploadMessageEvent extends ChatEvent {
  final String senderID;
  final String recieverID;
  final String message;
  const UploadMessageEvent({
    required this.senderID,
    required this.recieverID,
    required this.message,
  });

  @override
  List<Object?> get props => [senderID, recieverID, message];
}
