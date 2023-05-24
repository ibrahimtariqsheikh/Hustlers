// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CartProduct extends Equatable {
  final String productId;
  final String productName;
  final bool isWishlist;
  final String productDescription;
  final double price;
  final String imageURL;
  final String selectedSize;
  final String selectedColor;
  int quantity;

  CartProduct({
    required this.productId,
    required this.productName,
    required this.isWishlist,
    required this.productDescription,
    required this.price,
    required this.imageURL,
    required this.selectedSize,
    required this.selectedColor,
    required this.quantity,
  });

  @override
  List<Object> get props {
    return [
      productId,
      productName,
      productDescription,
      price,
      imageURL,
      selectedSize,
      selectedColor,
      quantity,
    ];
  }

  factory CartProduct.initial() {
    return CartProduct(
        productId: '',
        productName: '',
        productDescription: '',
        isWishlist: false,
        price: 0,
        imageURL: '',
        selectedSize: '',
        selectedColor: '',
        quantity: 1);
  }

  CartProduct copyWith({
    String? productId,
    String? productName,
    String? productDescription,
    bool? isWishlist,
    double? price,
    String? imageURL,
    String? selectedSize,
    String? selectedColor,
    int? quantity,
  }) {
    return CartProduct(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
      isWishlist: isWishlist ?? this.isWishlist,
      price: price ?? this.price,
      imageURL: imageURL ?? this.imageURL,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColor: selectedColor ?? this.selectedColor,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  bool get stringify => true;
}
