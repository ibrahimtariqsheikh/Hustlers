part of 'cart_cubit.dart';

enum CartStatus {
  initial,
  loading,
  loaded,
}

class CartState extends Equatable {
  final CartStatus cartStatus;
  final CustomError error;
  final double totalPayment;
  final List<CartProduct> cartProducts;
  final CartProduct currentProduct;

  const CartState({
    required this.cartStatus,
    required this.error,
    required this.totalPayment,
    required this.cartProducts,
    required this.currentProduct,
  });

  factory CartState.initial() {
    return CartState(
      cartProducts: const [],
      totalPayment: 0.0,
      currentProduct: CartProduct.initial(),
      cartStatus: CartStatus.initial,
      error: const CustomError(),
    );
  }

  @override
  List<Object> get props =>
      [cartStatus, error, cartProducts, currentProduct, totalPayment];

  @override
  bool get stringify => true;

  CartState copyWith({
    CartStatus? cartStatus,
    CustomError? error,
    List<CartProduct>? cartProducts,
    CartProduct? currentProduct,
    double? totalPayment,
  }) {
    return CartState(
      cartStatus: cartStatus ?? this.cartStatus,
      error: error ?? this.error,
      cartProducts: cartProducts ?? this.cartProducts,
      currentProduct: currentProduct ?? this.currentProduct,
      totalPayment: totalPayment ?? this.totalPayment,
    );
  }
}
