import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String categoryId;
  final String categoryName;

  const Category({
    required this.categoryId,
    required this.categoryName,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['_id'] ?? '',
      categoryName: json['Category_Name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': categoryId,
      'Category_Name': categoryName,
    };
  }

  @override
  List<Object> get props {
    return [
      categoryId,
      categoryName,
    ];
  }

  Category copyWith({
    String? categoryId,
    String? categoryName,
  }) {
    return Category(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  @override
  bool get stringify => true;
}
