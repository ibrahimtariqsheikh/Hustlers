import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:synew_gym/blocs/friends/repositories/friends_repository.dart';
import 'package:synew_gym/models/user_model.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  FriendsRepository friendsRepository;
  FriendsBloc({required this.friendsRepository})
      : super(FriendsState.initial()) {
    on<SearchUsersByUsernameEvent>((event, emit) {});
  }
}
