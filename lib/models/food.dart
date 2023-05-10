import 'package:equatable/equatable.dart';

class Food extends Equatable {
  final String id;
  final String name;
  final String brand;
  final int servingQty;
  final double calories;
  final double totalFat;
  final double protein;
  final double totalCarbs;

  const Food({
    required this.id,
    required this.name,
    required this.brand,
    required this.servingQty,
    required this.calories,
    required this.totalFat,
    required this.protein,
    required this.totalCarbs,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['nix_item_id'] ?? '',
      name: json['item_name'] ?? json['food_name'] ?? '',
      brand: json['brand_name'] ?? '',
      servingQty: json['serving_qty']?.toInt() ?? 1,
      calories: json['nf_calories']?.toDouble() ?? 0.0,
      totalFat: json['nf_total_fat']?.toDouble() ?? 0.0,
      protein: json['nf_protein']?.toDouble() ?? 0.0,
      totalCarbs: json['nf_total_carbohydrate']?.toDouble() ?? 0.0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'item_name': name,
      'brand_name': brand,
      'serving_qty': servingQty,
      'nf_calories': calories,
      'nf_total_fat': totalFat,
      'nf_protein': protein,
      'nf_total_carbohydrate': totalCarbs,
    };
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      brand,
      servingQty,
      calories,
      totalFat,
      protein,
      totalCarbs,
    ];
  }

  Food copyWith({
    String? id,
    String? name,
    String? brand,
    int? servingQty,
    double? calories,
    double? totalFat,
    double? protein,
    double? totalCarbs,
  }) {
    return Food(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      servingQty: servingQty ?? this.servingQty,
      calories: calories ?? this.calories,
      totalFat: totalFat ?? this.totalFat,
      protein: protein ?? this.protein,
      totalCarbs: totalCarbs ?? this.totalCarbs,
    );
  }

  @override
  bool get stringify => true;
}
