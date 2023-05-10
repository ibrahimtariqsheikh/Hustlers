// ignore_for_file: public_member_api_docs, sort_constructors_first
enum CategoryStatus {
  initial,
}

class CategoryState {
  final int index;
  final List<String> labels = [
    'Men\'s Apparel',
    'MensApparel',
    'Women\'s Apparel',
    'Men\'s Footwear',
    'Women\'s Footwear',
    'Accessories',
    'Nutrition',
  ];

  CategoryState({
    required this.index,
  });

  factory CategoryState.initial() {
    return CategoryState(index: 4);
  }

  CategoryState copyWith({
    int? index,
  }) {
    return CategoryState(
      index: index ?? this.index,
    );
  }

  @override
  String toString() => 'CategoryState(index: $index)';
}
