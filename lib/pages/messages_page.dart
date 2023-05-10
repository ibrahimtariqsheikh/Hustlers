import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:synew_gym/app_theme.dart';
import 'package:synew_gym/blocs/auth/auth_bloc.dart';
import 'package:synew_gym/blocs/chat/chat_bloc.dart';
import 'package:synew_gym/models/message_data.dart';
import 'package:synew_gym/pages/chat_screen.dart';

import 'package:synew_gym/widgets/avatar.dart';

import '../helpers.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String currUser = context.read<AuthBloc>().state.user!.uid;
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state.chatStatus == ChatStatus.loaded) {
          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              final user = state.users[index];

              if (user.id == currUser) {
                return Container();
              }

              return _MessageTitle(
                messageData: MessageData(
                  username: '${user.firstname} ${user.lastname}',
                  message: 'See message',
                  createdAt: user.lastMessageTime,
                  senderID: currUser,
                  recieverID: user.id,
                  urlAvatar: Helpers.randomPictureUrl(),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}

class _MessageTitle extends StatelessWidget {
  const _MessageTitle({
    Key? key,
    required this.messageData,
  }) : super(key: key);

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('h:mm a');
    final String formattedTime =
        formatter.format(messageData.createdAt.toLocal());
    return InkWell(
      onTap: () {
        Navigator.of(context).push(ChatScreen.route(messageData));
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.2,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Avatar.medium(url: messageData.urlAvatar),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        messageData.username,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          letterSpacing: 0.2,
                          wordSpacing: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: Text(
                        messageData.message,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textFaded,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      formattedTime,
                      style: const TextStyle(
                        fontSize: 11,
                        letterSpacing: -0.2,
                        color: AppColors.textFaded,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // Container(
                    //   width: 18,
                    //   height: 18,
                    //   decoration: const BoxDecoration(
                    //     color: AppColors.secondary,
                    //     shape: BoxShape.circle,
                    //   ),
                    //   child: const Center(
                    //     child: Text(
                    //       '2',
                    //       style: TextStyle(
                    //         fontSize: 10,
                    //         color: AppColors.textLight,
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
