// ignore_for_file: public_member_api_docs, sort_constructors_first
enum TabBarStatus {
  initial,
}

class TabBarState {
  final int index;
  const TabBarState({
    required this.index,
  });

  factory TabBarState.initial() {
    return const TabBarState(index: 4);
  }

  TabBarState copyWith({
    int? index,
  }) {
    return TabBarState(
      index: index ?? this.index,
    );
  }

  @override
  String toString() => 'TabBarState(index: $index)';
}
