part of 'friends_bloc.dart';

abstract class FriendsEvent extends Equatable {
  const FriendsEvent();

  @override
  List<Object?> get props => [];
}

class SearchUsersByUsernameEvent extends FriendsEvent {
  final String username;

  const SearchUsersByUsernameEvent({
    required this.username,
  });

  @override
  List<Object?> get props => [username];
}
