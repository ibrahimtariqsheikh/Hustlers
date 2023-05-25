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

class ShareWorkoutEvent extends FriendsEvent {
  final String friendId;
  final Workout workout;

  const ShareWorkoutEvent({
    required this.friendId,
    required this.workout,
  });

  @override
  List<Object?> get props => [friendId, workout];
}
