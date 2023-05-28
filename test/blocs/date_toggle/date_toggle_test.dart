import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:synew_gym/blocs/date_toggle/cubit/date_toggle_cubit.dart';

void main() {
  group('DateToggleCubit', () {
    late DateToggleCubit dateToggleCubit;

    setUp(() {
      dateToggleCubit = DateToggleCubit();
    });

    tearDown(() {
      dateToggleCubit.close();
    });

    test('initial state is correct', () {
      expect(dateToggleCubit.state.selectedDate.day, DateTime.now().day);
    });

    blocTest<DateToggleCubit, DateState>(
      'emits [selectedDate] when dateButtonPressed is called',
      build: () => dateToggleCubit,
      act: (cubit) => cubit.dateButtonPressed(DateTime(2023, 1, 1)),
      expect: () => [
        DateState(selectedDate: DateTime(2023, 1, 1)),
      ],
    );
  });
}
