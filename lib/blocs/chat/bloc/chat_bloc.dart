import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synew_gym/models/message_data.dart';
import 'package:synew_gym/models/user_model.dart';
import 'package:synew_gym/blocs/chat/repository/message_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final MessageRepository messageRepository;
  late final StreamSubscription userSubscription;

  ChatBloc({required this.messageRepository}) : super(ChatState.initial()) {
    userSubscription = messageRepository.availableUsers.listen((users) {
      add(GetUserEvent(users: users));
    });

    on<GetUserEvent>((event, emit) {
      if (event.users != []) {
        emit(state.copyWith(
          chatStatus: ChatStatus.loaded,
          users: event.users,
        ));
      } else {
        emit(state.copyWith(
          chatStatus: ChatStatus.loading,
          users: [],
        ));
      }
    });

    on<UploadMessageEvent>((event, emit) async {
      await messageRepository.uploadMessage(
        event.senderID,
        event.recieverID,
        event.message,
      );
    });
  }
  Stream<List<MessageData>> getMessages(String senderID, String receiverID) {
    return messageRepository.getMessages(senderID, receiverID);
  }
}
