part of 'date_toggle_cubit.dart';

enum DateStatus { initial, loading, loaded, error }

class DateState {
  final DateTime selectedDate;

  DateState({
    required this.selectedDate,
  });

  factory DateState.initial() {
    DateTime selectedDate = DateTime.now();

    return DateState(selectedDate: selectedDate);
  }

  DateState copyWith({
    DateTime? selectedDate,
  }) {
    return DateState(
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  @override
  String toString() => 'DateState(selectedDate: $selectedDate)';
}
