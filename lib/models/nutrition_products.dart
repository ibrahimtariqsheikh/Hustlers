import 'package:equatable/equatable.dart';

class NutritionProduct extends Equatable {
  final String productId;
  final String productName;
  final String productDescription;
  final String productWeight;
  final int stockQty;
  final double price;
  final double rating;
  final List<String> imageURL;

  const NutritionProduct({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.stockQty,
    required this.price,
    required this.rating,
    required this.imageURL,
    required this.productWeight,
  });

  factory NutritionProduct.fromJson(Map<String, dynamic> json) {
    return NutritionProduct(
      productId: json['_id'] ?? '',
      productName: json['Product_Name'] ?? '',
      productDescription: json['Product_Description'] ?? '',
      productWeight: json['Weight'] ?? '',
      stockQty: json['Stock_Qty']?.toInt() ?? 0,
      price: json['Price']?.toDouble() ?? 0.0,
      rating: json['Rating']?.toDouble() ?? 0.0,
      imageURL: List<String>.from(json['Image_URL'] ?? []),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': productId,
      'Product_Name': productName,
      'Product_Description': productDescription,
      'Weight': productWeight,
      'Stock_Qty': stockQty,
      'Price': price,
      'Rating': rating,
      'Image_URL': imageURL,
    };
  }

  @override
  List<Object> get props {
    return [
      productId,
      productName,
      productDescription,
      stockQty,
      price,
      rating,
      imageURL,
    ];
  }

  NutritionProduct copyWith({
    String? productId,
    String? productName,
    String? productDescription,
    int? stockQty,
    double? price,
    double? rating,
    List<String>? imageURL,
    String? productWeight,
  }) {
    return NutritionProduct(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
      stockQty: stockQty ?? this.stockQty,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      imageURL: imageURL ?? this.imageURL,
      productWeight: productWeight ?? this.productWeight,
    );
  }

  @override
  bool get stringify => true;
}
