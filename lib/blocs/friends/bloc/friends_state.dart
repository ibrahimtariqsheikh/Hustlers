part of 'friends_bloc.dart';

enum FriendsStatus {
  initial,
  loading,
  loaded,
  error,
}

class FriendsState extends Equatable {
  final FriendsStatus friendsStatus;
  final List<User> fetchedUsers;

  const FriendsState({
    required this.friendsStatus,
    required this.fetchedUsers,
  });

  factory FriendsState.initial() {
    return const FriendsState(
      friendsStatus: FriendsStatus.initial,
      fetchedUsers: [],
    );
  }

  @override
  List<Object> get props => [friendsStatus, fetchedUsers];

  FriendsState copyWith({
    FriendsStatus? friendsStatus,
    List<User>? fetchedUsers,
  }) {
    return FriendsState(
      friendsStatus: friendsStatus ?? this.friendsStatus,
      fetchedUsers: fetchedUsers ?? this.fetchedUsers,
    );
  }

  @override
  bool get stringify => true;
}
