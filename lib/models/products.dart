import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String productId;
  final String productName;
  final String productDescription;
  final int stockQty;
  final double price;
  final double rating;
  final List<String> imageURL;
  final List<String> size;
  final List<String> color;
  final double productWeight;
  final String category;

  const Product({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.stockQty,
    required this.price,
    required this.rating,
    required this.imageURL,
    required this.size,
    required this.color,
    required this.productWeight,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        productId: json['_id'] ?? '',
        productName: json['Product_Name'] ?? '',
        productDescription: json['Product_Description'] ?? '',
        stockQty: json['Stock_Qty']?.toInt() ?? 0,
        price: json['Price']?.toDouble() ?? 0.0,
        rating: json['Rating']?.toDouble() ?? 0.0,
        imageURL: List<String>.from(json['Image_URL'] ?? []),
        size: List<String>.from(json['Size'] ?? []),
        color: List<String>.from(json['Color'] ?? []),
        productWeight: json['productWeight'] ?? 0.0,
        category: json['Category']?['_ref'] ?? '');
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
      'Size': size,
      'Color': color,
      'Product_Weight': productWeight,
      'Category': category,
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
      size,
      color,
      productWeight,
      category,
    ];
  }

  Product copyWith(
      {String? productId,
      String? productName,
      String? productDescription,
      int? stockQty,
      double? price,
      double? rating,
      List<String>? imageURL,
      List<String>? size,
      List<String>? color,
      double? productWeight,
      String? category}) {
    return Product(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
      stockQty: stockQty ?? this.stockQty,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      imageURL: imageURL ?? this.imageURL,
      size: size ?? this.size,
      color: color ?? this.color,
      productWeight: productWeight ?? this.productWeight,
      category: category ?? this.category,
    );
  }

  @override
  bool get stringify => true;
}
