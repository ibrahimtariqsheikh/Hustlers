import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synew_gym/models/category.dart';
import 'package:synew_gym/models/products.dart';
import 'package:synew_gym/models/custom_error.dart';
import 'package:synew_gym/blocs/product/repository/shop_repository.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ShopRepository shopRepository;

  ProductBloc({required this.shopRepository}) : super(ProductState.initial()) {
    on<FetchAllProductsEvent>((event, emit) async {
      emit(state.copyWith(productStatus: ProductStatus.loading));
      try {
        final List<Product> mensApparel =
            await shopRepository.fetchMensApparel();
        final List<Product> womensApparel =
            await shopRepository.fetchWomensApparel();
        final List<Product> mensFootwear =
            await shopRepository.fetchMensFootwear();
        final List<Product> womensFootwear =
            await shopRepository.fetchWomensFootwear();
        final List<Product> accessories =
            await shopRepository.fetchAccessories();
        final List<Product> nutrition = await shopRepository.fetchNutrition();
        final List<Category> categories = await shopRepository.fetchCategory();
        emit(state.copyWith(
          productStatus: ProductStatus.loaded,
          mensApparel: mensApparel,
          womensApparel: womensApparel,
          mensFootwear: mensFootwear,
          womensFootwear: womensFootwear,
          accessoryItems: accessories,
          nutritionItems: nutrition,
          selectedProducts: mensApparel,
          categories: categories,
        ));
      } catch (e) {
        emit(state.copyWith(productStatus: ProductStatus.error));
      }
    });

    on<ChangeSelectedProductEvent>((event, emit) async {
      emit(state.copyWith(productStatus: ProductStatus.loading));
      List<Product> selectedProduct = [];
      if (event.label == 'Men\'s Apparel') {
        selectedProduct = List.from(state.mensApparel);
      } else if (event.label == 'Women\'s Apparel') {
        selectedProduct = List.from(state.womensApparel);
      } else if (event.label == 'Men\'s Footwear') {
        selectedProduct = List.from(state.mensFootwear);
      } else if (event.label == 'Women\'s Footwear') {
        selectedProduct = List.from(state.womensFootwear);
      } else if (event.label == 'Accessories') {
        selectedProduct = List.from(state.accessoryItems);
      } else if (event.label == 'Nutrition') {
        selectedProduct = List.from(state.nutritionItems);
      }
      emit(state.copyWith(
        productStatus: ProductStatus.loaded,
        selectedProducts: selectedProduct,
      ));
    });

    on<FetchProductsBySearchEvent>((event, emit) async {
      emit(state.copyWith(productStatus: ProductStatus.loading));
      List<Product> selectedProducts = [];
      String id = '';
      if (event.query != '') {
        for (Category category in state.categories) {
          if (category.categoryName
              .toLowerCase()
              .contains(event.query.toLowerCase())) {
            id = category.categoryId;
          }
        }
        selectedProducts.addAll(searchProducts(state.mensApparel, id));
        selectedProducts.addAll(searchProducts(state.womensApparel, id));
        selectedProducts.addAll(searchProducts(state.accessoryItems, id));
        selectedProducts.addAll(searchProducts(state.mensFootwear, id));
        selectedProducts.addAll(searchProducts(state.womensFootwear, id));
        selectedProducts.addAll(searchProducts(state.nutritionItems, id));

        emit(state.copyWith(
          productStatus: ProductStatus.loaded,
          selectedProducts: selectedProducts,
        ));
      }
    });
  }
}

List<Product> searchProducts(List<Product> products, String catID) {
  List<Product> selectedProducts = [];
  for (Product product in products) {
    if (product.category == catID) {
      selectedProducts.add(product);
    }
  }
  return selectedProducts;
}
