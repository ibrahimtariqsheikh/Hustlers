// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

enum ProductStatus {
  initial,
  loading,
  loaded,
  error,
}

// ignore: must_be_immutable
class ProductState extends Equatable {
  final ProductStatus productStatus;
  final List<Product> mensApparel;
  final List<Product> womensApparel;
  final List<Product> mensFootwear;
  final List<Product> womensFootwear;
  final List<Product> nutritionItems;
  final List<Product> accessoryItems;
  final List<Product> selectedProducts;
  final CustomError error;

  const ProductState({
    required this.productStatus,
    required this.mensApparel,
    required this.womensApparel,
    required this.mensFootwear,
    required this.womensFootwear,
    required this.accessoryItems,
    required this.nutritionItems,
    required this.error,
    required this.selectedProducts,
  });

  factory ProductState.initial() {
    return const ProductState(
      productStatus: ProductStatus.initial,
      mensApparel: [],
      womensApparel: [],
      mensFootwear: [],
      womensFootwear: [],
      accessoryItems: [],
      nutritionItems: [],
      selectedProducts: [],
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [
        productStatus,
        mensApparel,
        womensApparel,
        mensFootwear,
        womensFootwear,
        accessoryItems,
        nutritionItems,
        selectedProducts,
        error,
      ];

  ProductState copyWith({
    ProductStatus? productStatus,
    List<Product>? mensApparel,
    List<Product>? womensApparel,
    List<Product>? mensFootwear,
    List<Product>? womensFootwear,
    List<Product>? accessoryItems,
    List<Product>? nutritionItems,
    List<Product>? selectedProducts,
    CustomError? error,
  }) {
    return ProductState(
      productStatus: productStatus ?? this.productStatus,
      mensApparel: mensApparel ?? this.mensApparel,
      womensApparel: womensApparel ?? this.womensApparel,
      mensFootwear: mensFootwear ?? this.mensFootwear,
      womensFootwear: womensFootwear ?? this.womensFootwear,
      accessoryItems: accessoryItems ?? this.accessoryItems,
      nutritionItems: nutritionItems ?? this.nutritionItems,
      selectedProducts: selectedProducts ?? this.selectedProducts,
      error: error ?? this.error,
    );
  }

  @override
  bool get stringify => true;
}
