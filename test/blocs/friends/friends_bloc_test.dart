import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:synew_gym/blocs/friends/bloc/friends_bloc.dart';
import 'package:synew_gym/blocs/profile/cubit/profile_cubit.dart';
import 'package:synew_gym/models/user_model.dart';
import 'package:synew_gym/models/workout.dart';
import 'package:synew_gym/blocs/friends/repositories/friends_repository.dart';

class MockFriendsRepository extends Mock implements FriendsRepository {}

class MockProfileCubit extends Mock implements ProfileCubit {}

void main() {
  group('FriendsBloc', () {
    late FriendsRepository friendsRepository;
    late ProfileCubit profileCubit;
    late FriendsBloc friendsBloc;

    setUp(() {
      friendsRepository = MockFriendsRepository();
      profileCubit = MockProfileCubit();
      friendsBloc = FriendsBloc(
        friendsRepository: friendsRepository,
        profileCubit: profileCubit,
      );
    });

    tearDown(() {
      friendsBloc.close();
    });

    test('initial state is correct', () {
      expect(friendsBloc.state, FriendsState.initial());
    });

    blocTest<FriendsBloc, FriendsState>(
      'emits [loaded] and [fetchedUsers] when SearchUsersByNameEvent is added.',
      build: () {
        when(friendsRepository.searchUserByUsername('hussainmurtaza'))
            .thenAnswer((_) async => [User.initial()]);
        return friendsBloc;
      },
      act: (bloc) => bloc.add(const SearchUsersByNameEvent(name: 'test')),
      expect: () => [
        const FriendsState(
            friendsStatus: FriendsStatus.loaded, fetchedUsers: []),
        FriendsState(
            friendsStatus: FriendsStatus.loaded,
            fetchedUsers: [User.initial()]),
      ],
    );

    blocTest<FriendsBloc, FriendsState>(
      'emits nothing when AddFriendEvent is added.',
      build: () {
        when(friendsRepository.addFriend('id1', 'id2'))
            .thenAnswer((_) async {});
        return friendsBloc;
      },
      act: (bloc) => bloc
          .add(const AddFriendEvent(loggedInUserId: '123', friendId: '456')),
      expect: () => [],
    );

    blocTest<FriendsBloc, FriendsState>(
      'emits nothing when ShareWorkoutEvent is added.',
      build: () {
        when(friendsRepository.shareWorkout('123', Workout.initial()))
            .thenAnswer((_) async {});
        return friendsBloc;
      },
      act: (bloc) => bloc
          .add(ShareWorkoutEvent(friendId: '123', workout: Workout.initial())),
      expect: () => [],
    );
  });
}
