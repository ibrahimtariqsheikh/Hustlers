part of 'friends_bloc.dart';

abstract class FriendsEvent extends Equatable {
  const FriendsEvent();

  @override
  List<Object?> get props => [];
}

class GetUserEvent extends FriendsEvent {
  final List<User> users;
  const GetUserEvent({required this.users});

  @override
  List<Object?> get props => [users];
}
