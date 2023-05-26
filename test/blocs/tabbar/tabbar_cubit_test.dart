import 'package:flutter_test/flutter_test.dart';
import 'package:synew_gym/blocs/tab_bar/cubit/tab_bar_cubit.dart';
import 'package:synew_gym/blocs/tab_bar/cubit/tab_bar_state.dart';

void main() {
  group('TabBarCubit', () {
    late TabBarCubit tabBarCubit;

    setUp(() {
      tabBarCubit = TabBarCubit();
    });

    tearDown(() {
      tabBarCubit.close();
    });

    test('initial state is correct', () {
      expect(tabBarCubit.state, TabBarState.initial());
    });

    // blocTest<TabBarCubit, TabBarState>(
    //   'emits [TabBarState] when tabBarPressed is called',
    //   build: () => tabBarCubit,
    //   act: (cubit) => cubit.tabBarPressed(2),
    //   expect: () => [const TabBarState(index: 2)],
    // );
  });
}
