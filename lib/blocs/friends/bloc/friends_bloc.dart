import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:synew_gym/blocs/friends/repositories/friends_repository.dart';
import 'package:synew_gym/blocs/profile/cubit/profile_cubit.dart';
import 'package:synew_gym/models/user_model.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  FriendsRepository friendsRepository;
  ProfileCubit profileCubit;
  FriendsBloc({required this.friendsRepository, required this.profileCubit})
      : super(FriendsState.initial()) {
    on<SearchUsersByNameEvent>((event, emit) async {
      emit(state.copyWith(friendsStatus: FriendsStatus.loaded));
      List<User> fetchedUsers =
          await friendsRepository.searchUserByUsername(event.name);
      emit(state.copyWith(
        fetchedUsers: fetchedUsers,
        friendsStatus: FriendsStatus.loaded,
      ));
    });

    on<AddFriendEvent>((event, emit) async {
      profileCubit.addFriend(friendId: event.friendId);
      await friendsRepository.addFriend(event.loggedInUserId, event.friendId);
    });
  }
}
