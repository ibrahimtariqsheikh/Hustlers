import 'package:equatable/equatable.dart';

class Accessories extends Equatable {
  final String productId;
  final String productName;
  final String productDescription;
  final int stockQty;
  final double price;
  final double rating;
  final List<String> imageURL;

  const Accessories({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.stockQty,
    required this.price,
    required this.rating,
    required this.imageURL,
  });

  factory Accessories.fromJson(Map<String, dynamic> json) {
    return Accessories(
      productId: json['_id'] ?? '',
      productName: json['Product_Name'] ?? '',
      productDescription: json['Product_Description'] ?? '',
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

  Accessories copyWith({
    String? productId,
    String? productName,
    String? productDescription,
    int? stockQty,
    double? price,
    double? rating,
    List<String>? imageURL,
  }) {
    return Accessories(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
      stockQty: stockQty ?? this.stockQty,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      imageURL: imageURL ?? this.imageURL,
    );
  }

  @override
  bool get stringify => true;
}
