part of 'friends_bloc.dart';

abstract class FriendsEvent extends Equatable {
  const FriendsEvent();

  @override
  List<Object?> get props => [];
}

class SearchUsersByNameEvent extends FriendsEvent {
  final String name;

  const SearchUsersByNameEvent({
    required this.name,
  });

  @override
  List<Object?> get props => [name];
}

class AddFriendEvent extends FriendsEvent {
  final String loggedInUserId;
  final String friendId;

  const AddFriendEvent({
    required this.loggedInUserId,
    required this.friendId,
  });

  @override
  List<Object?> get props => [loggedInUserId, friendId];
}
