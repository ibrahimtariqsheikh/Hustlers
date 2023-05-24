import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:synew_gym/models/user_model.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  FriendsBloc() : super(FriendsState.initial()) {
    on<GetUserEvent>((event, emit) {
      if (event.users != []) {
        emit(state.copyWith(
          friendsStatus: FriendsStatus.loaded,
          users: event.users,
        ));
      } else {
        emit(state.copyWith(
          friendsStatus: FriendsStatus.loading,
          users: [],
        ));
      }
    });
  }
}
