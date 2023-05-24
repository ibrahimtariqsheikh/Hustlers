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
    for (CartProduct product in products) {
      if (product.productId == state.currentProduct.productId) {
        product.quantity += 1;
        emit(state.copyWith(
          cartProducts: products,
          totalPayment: state.totalPayment + state.currentProduct.price,
          cartStatus: CartStatus.loaded,
          currentProduct: CartProduct.initial(),
        ));
        return;
      }
    }
    products.add(state.currentProduct);
    emit(state.copyWith(
      cartProducts: products,
      totalPayment: state.totalPayment + state.currentProduct.price,
      cartStatus: CartStatus.loaded,
      currentProduct: CartProduct.initial(),
    ));
  }

  void changeQuantity(CartProduct productToChange, bool increment) {
    print(increment);
    List<CartProduct> products = List.from(state.cartProducts);
    for (CartProduct product in products) {
      if (product.productId == productToChange.productId) {
        if (product.quantity <= 1 && !increment) {
          deleteFromCart(product);
          return;
        } else {
          increment ? product.quantity += 1 : product.quantity -= 1;
        }
      }
      break;
    }
    emit(state.copyWith(
      cartProducts: products,
      totalPayment: increment
          ? state.totalPayment + productToChange.price
          : state.totalPayment - productToChange.price,
      cartStatus: CartStatus.loaded,
      currentProduct: CartProduct.initial(),
    ));
  }

  void deleteFromCart(CartProduct productToBeDeleted) {
    emit(state.copyWith(cartStatus: CartStatus.loading));
    List<CartProduct> updatedProducts;
    updatedProducts = state.cartProducts
        .where((product) => product.productId != productToBeDeleted.productId)
        .toList();
    emit(state.copyWith(
      cartProducts: updatedProducts,
      totalPayment: state.totalPayment -
          (productToBeDeleted.price * productToBeDeleted.quantity),
      cartStatus: CartStatus.loaded,
    ));
    print('product ${productToBeDeleted.productName} is deleted');
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
