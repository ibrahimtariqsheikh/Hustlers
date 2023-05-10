part of 'chat_bloc.dart';

enum ChatStatus {
  initial,
  loading,
  loaded,
}

class ChatState extends Equatable {
  final ChatStatus chatStatus;
  final List<User> users;
  final List<MessageData> messages;

  const ChatState({
    required this.chatStatus,
    required this.users,
    required this.messages,
  });

  factory ChatState.initial() {
    return const ChatState(
      chatStatus: ChatStatus.initial,
      users: [],
      messages: [],
    );
  }

  @override
  List<Object?> get props => [chatStatus];

  ChatState copyWith({
    ChatStatus? chatStatus,
    List<User>? users,
    List<MessageData>? messages,
  }) {
    return ChatState(
      chatStatus: chatStatus ?? this.chatStatus,
      users: users ?? this.users,
      messages: messages ?? this.messages,
    );
  }

  @override
  bool get stringify => true;
}
