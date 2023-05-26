import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:synew_gym/blocs/cart/cubit/cart_cubit.dart';
import 'package:synew_gym/models/cart_product.dart';
import 'package:synew_gym/models/custom_error.dart';
import 'package:synew_gym/models/products.dart';

void main() {
  group('CartCubit', () {
    late CartCubit cartCubit;

    setUp(() {
      cartCubit = CartCubit();
    });

    tearDown(() {
      cartCubit.close();
    });

    test('Initial state is CartState.initial', () {
      expect(cartCubit.state, CartState.initial());
    });

    blocTest<CartCubit, CartState>(
      'should update selected product when updateSelectedProduct is called',
      build: () => cartCubit,
      act: (cubit) {
        Product product = const Product(
          productId: "1",
          stockQty: 10,
          rating: 5,
          category: 'all',
          productWeight: 10,
          color: ['000000'],
          size: ['S'],
          productName: "TestProduct",
          productDescription: "Description",
          imageURL: ["imageURL"],
          price: 10.0,
        );
        cubit.updateSelectedProduct(product);
      },
      expect: () => [
        CartState(
          cartStatus: CartStatus.initial,
          currentProduct: CartProduct(
            productDescription: "Description",
            productId: "1",
            isWishlist: false,
            selectedSize: '',
            selectedColor: '',
            productName: "TestProduct",
            imageURL: "imageURL",
            price: 10.0,
            quantity: 1,
          ),
          cartProducts: const [],
          totalPayment: 0.0,
          error: const CustomError(),
        ),
      ],
    );

    blocTest<CartCubit, CartState>(
      'should add product to cart when addToCart is called',
      build: () => cartCubit,
      act: (cubit) {
        Product product = const Product(
          productId: "1",
          stockQty: 10,
          rating: 5,
          category: 'all',
          productWeight: 10,
          color: ['000000'],
          size: ['S'],
          productName: "TestProduct",
          productDescription: "Description",
          imageURL: ["imageURL"],
          price: 10.0,
        );
        cubit.updateSelectedProduct(product);
        cubit.addToCart();
      },
      expect: () => [
        CartState(
          cartStatus: CartStatus.initial,
          currentProduct: CartProduct(
            productDescription: "Description",
            productId: "1",
            isWishlist: false,
            selectedSize: '',
            selectedColor: '',
            productName: "TestProduct",
            imageURL: "imageURL",
            price: 10.0,
            quantity: 1,
          ),
          cartProducts: const [],
          totalPayment: 0.0,
          error: const CustomError(),
        ),
        CartState(
          cartStatus: CartStatus.loading,
          currentProduct: CartProduct(
            productDescription: "Description",
            productId: "1",
            isWishlist: false,
            selectedSize: '',
            selectedColor: '',
            productName: "TestProduct",
            imageURL: "imageURL",
            price: 10.0,
            quantity: 1,
          ),
          cartProducts: const [],
          totalPayment: 0.0,
          error: const CustomError(),
        ),
        CartState(
          cartStatus: CartStatus.loaded,
          currentProduct: CartProduct.initial(),
          cartProducts: [
            CartProduct(
              productDescription: "Description",
              productId: "1",
              isWishlist: false,
              selectedSize: '',
              selectedColor: '',
              productName: "TestProduct",
              imageURL: "imageURL",
              price: 10.0,
              quantity: 1,
            ),
          ],
          totalPayment: 10.0,
          error: const CustomError(),
        ),
      ],
    );
  });
}
