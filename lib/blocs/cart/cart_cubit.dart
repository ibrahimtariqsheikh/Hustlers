import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:synew_gym/models/cart_product.dart';
import 'package:synew_gym/models/custom_error.dart';
import 'package:synew_gym/models/products.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState.initial());

  void updateSelectedProduct(Product product) {
    CartProduct currentProduct = state.currentProduct;
    currentProduct = currentProduct.copyWith(
      productDescription: product.productDescription,
      productId: product.productId,
      productName: product.productName,
      imageURL: product.imageURL[0],
      price: product.price,
    );
    emit(state.copyWith(currentProduct: currentProduct));
  }

  void addToCart() {
    emit(state.copyWith(cartStatus: CartStatus.loading));
    List<CartProduct> products = List.from(state.cartProducts);
    products.add(state.currentProduct);
    emit(state.copyWith(
      cartProducts: products,
      totalPayment: state.totalPayment + state.currentProduct.price,
      cartStatus: CartStatus.loaded,
      currentProduct: CartProduct.initial(),
    ));
  }

  void selectSize(String size) {
    emit(state.copyWith(cartStatus: CartStatus.loading));
    CartProduct cartProduct = state.currentProduct;
    cartProduct = cartProduct.copyWith(selectedSize: size);
    emit(state.copyWith(
        cartStatus: CartStatus.loaded, currentProduct: cartProduct));
  }

  void selectColor(String color) {
    emit(state.copyWith(cartStatus: CartStatus.loading));
    CartProduct cartProduct = state.currentProduct;
    cartProduct = cartProduct.copyWith(selectedColor: color);
    emit(state.copyWith(
        cartStatus: CartStatus.loaded, currentProduct: cartProduct));
  }

  void toggleIsWishlist() {
    emit(state.copyWith(cartStatus: CartStatus.loading));
    CartProduct cartProduct = state.currentProduct;
    cartProduct =
        cartProduct.copyWith(isWishlist: !state.currentProduct.isWishlist);
    emit(state.copyWith(
        cartStatus: CartStatus.loaded, currentProduct: cartProduct));
  }
}
