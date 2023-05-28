part of 'date_toggle_cubit.dart';

enum DateStatus { initial, loading, loaded, error }

class DateState extends Equatable {
  final DateTime selectedDate;

  const DateState({
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

  @override
  List<Object?> get props => [selectedDate];
}
