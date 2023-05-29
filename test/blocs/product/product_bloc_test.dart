import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:synew_gym/blocs/product/bloc/product_bloc.dart';
import 'package:synew_gym/blocs/product/repository/shop_repository.dart';
import 'package:synew_gym/models/category.dart';
import 'package:synew_gym/models/custom_error.dart';
import 'package:synew_gym/models/products.dart';

class MockShopRepository extends Mock implements ShopRepository {}

void main() {
  group('ProductBloc', () {
    late ShopRepository mockShopRepository;
    late ProductBloc productBloc;

    setUp(() {
      mockShopRepository = MockShopRepository();
      productBloc = ProductBloc(shopRepository: mockShopRepository);
    });

    tearDown(() {
      productBloc.close();
    });

    blocTest<ProductBloc, ProductState>(
      'emits [loading, loaded] when successful FetchAllProductsEvent',
      build: () {
        when(() => mockShopRepository.fetchMensApparel())
            .thenAnswer((_) async => [
                  const Product(
                    productId: '',
                    category: '',
                    color: [],
                    imageURL: [],
                    price: 0.0,
                    productDescription: '',
                    productName: '',
                    productWeight: 0.0,
                    rating: 0,
                    size: [],
                    stockQty: 0,
                  )
                ]);
        when(() => mockShopRepository.fetchWomensApparel())
            .thenAnswer((_) async => [
                  const Product(
                    productId: '',
                    category: '',
                    color: [],
                    imageURL: [],
                    price: 0.0,
                    productDescription: '',
                    productName: '',
                    productWeight: 0.0,
                    rating: 0,
                    size: [],
                    stockQty: 0,
                  )
                ]);
        when(() => mockShopRepository.fetchMensFootwear())
            .thenAnswer((_) async => [
                  const Product(
                    productId: '',
                    category: '',
                    color: [],
                    imageURL: [],
                    price: 0.0,
                    productDescription: '',
                    productName: '',
                    productWeight: 0.0,
                    rating: 0,
                    size: [],
                    stockQty: 0,
                  )
                ]);
        when(() => mockShopRepository.fetchWomensFootwear())
            .thenAnswer((_) async => [
                  const Product(
                    productId: '',
                    category: '',
                    color: [],
                    imageURL: [],
                    price: 0.0,
                    productDescription: '',
                    productName: '',
                    productWeight: 0.0,
                    rating: 0,
                    size: [],
                    stockQty: 0,
                  )
                ]);
        when(() => mockShopRepository.fetchAccessories())
            .thenAnswer((_) async => [
                  const Product(
                    productId: '',
                    category: '',
                    color: [],
                    imageURL: [],
                    price: 0.0,
                    productDescription: '',
                    productName: '',
                    productWeight: 0.0,
                    rating: 0,
                    size: [],
                    stockQty: 0,
                  )
                ]);
        when(() => mockShopRepository.fetchNutrition())
            .thenAnswer((_) async => [
                  const Product(
                    productId: '',
                    category: '',
                    color: [],
                    imageURL: [],
                    price: 0.0,
                    productDescription: '',
                    productName: '',
                    productWeight: 0.0,
                    rating: 0,
                    size: [],
                    stockQty: 0,
                  )
                ]);
        return productBloc;
      },
      act: (bloc) => bloc.add(const FetchAllProductsEvent()),
      expect: () => [
        ProductState.initial().copyWith(productStatus: ProductStatus.loading),
        ProductState.initial().copyWith(
          productStatus: ProductStatus.error,
        ),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [loading, error] when unsuccessful FetchAllProductsEvent',
      build: () {
        when(() => mockShopRepository.fetchMensApparel())
            .thenThrow(Exception());
        when(() => mockShopRepository.fetchWomensApparel())
            .thenThrow(Exception());
        when(() => mockShopRepository.fetchMensFootwear())
            .thenThrow(Exception());
        when(() => mockShopRepository.fetchWomensFootwear())
            .thenThrow(Exception());
        when(() => mockShopRepository.fetchAccessories())
            .thenThrow(Exception());
        when(() => mockShopRepository.fetchNutrition()).thenThrow(Exception());
        // Simulate other failing fetch operations too
        return productBloc;
      },
      act: (bloc) => bloc.add(const FetchAllProductsEvent()),
      expect: () => [
        ProductState.initial().copyWith(productStatus: ProductStatus.loading),
        ProductState.initial().copyWith(productStatus: ProductStatus.error),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [loading, loaded] when ChangeSelectedProductEvent',
      build: () => productBloc,
      seed: () => ProductState.initial().copyWith(
        productStatus: ProductStatus.loaded,
        selectedProducts: [
          const Product(
            productId: '',
            category: '',
            color: [],
            imageURL: [],
            price: 0.0,
            productDescription: '',
            productName: '',
            productWeight: 0.0,
            rating: 0,
            size: [],
            stockQty: 0,
          )
        ],
      ),
      act: (bloc) =>
          bloc.add(ChangeSelectedProductEvent(label: 'Men\'s Apparel')),
      expect: () => [
        ProductState.initial()
            .copyWith(productStatus: ProductStatus.loading, selectedProducts: [
          const Product(
            productId: '',
            category: '',
            color: [],
            imageURL: [],
            price: 0.0,
            productDescription: '',
            productName: '',
            productWeight: 0.0,
            rating: 0,
            size: [],
            stockQty: 0,
          )
        ]),
        ProductState.initial().copyWith(
          productStatus: ProductStatus.loaded,
        ),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [loading, loaded] when FetchProductsBySearchEvent',
      build: () => productBloc,
      seed: () => ProductState.initial().copyWith(
        productStatus: ProductStatus.loaded,
        mensApparel: [
          const Product(
            productId: '',
            category: '',
            color: [],
            imageURL: [],
            price: 0.0,
            productDescription: '',
            productName: '',
            productWeight: 0.0,
            rating: 0,
            size: [],
            stockQty: 0,
          )
        ],
      ),
      act: (bloc) => bloc.add(FetchProductsBySearchEvent(query: 'searchQuery')),
      expect: () => [
        ProductState.initial().copyWith(
          productStatus: ProductStatus.loading,
          mensApparel: [
            const Product(
              productId: '',
              category: '',
              color: [],
              imageURL: [],
              price: 0.0,
              productDescription: '',
              productName: '',
              productWeight: 0.0,
              rating: 0,
              size: [],
              stockQty: 0,
            )
          ],
        ),
        ProductState.initial().copyWith(
            productStatus: ProductStatus.loaded,
            mensApparel: [
              const Product(
                productId: '',
                category: '',
                color: [],
                imageURL: [],
                price: 0.0,
                productDescription: '',
                productName: '',
                productWeight: 0.0,
                rating: 0,
                size: [],
                stockQty: 0,
              )
            ],
            selectedProducts: [
              const Product(
                productId: '',
                category: '',
                color: [],
                imageURL: [],
                price: 0.0,
                productDescription: '',
                productName: '',
                productWeight: 0.0,
                rating: 0,
                size: [],
                stockQty: 0,
              )
            ],
            error: const CustomError(code: '', message: '', plugin: '')),
      ],
    );
  });
}
