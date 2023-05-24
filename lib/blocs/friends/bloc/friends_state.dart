part of 'friends_bloc.dart';

enum FriendsStatus {
  initial,
  loading,
  loaded,
}

class FriendsState extends Equatable {
  final FriendsStatus friendsStatus;
  final List<User> users;

  const FriendsState({
    required this.friendsStatus,
    required this.users,
  });

  factory FriendsState.initial() {
    return const FriendsState(
      friendsStatus: FriendsStatus.initial,
      users: [],
    );
  }

  @override
  List<Object> get props => [friendsStatus, users];

  FriendsState copyWith({
    FriendsStatus? friendsStatus,
    List<User>? users,
  }) {
    return FriendsState(
      friendsStatus: friendsStatus ?? this.friendsStatus,
      users: users ?? this.users,
    );
  }

  @override
  bool get stringify => true;
}
