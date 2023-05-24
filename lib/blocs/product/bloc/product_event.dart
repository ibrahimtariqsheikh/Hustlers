// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class FetchProductsBySearchEvent extends ProductEvent {
  final String query;

  const FetchProductsBySearchEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class FetchAllProductsEvent extends ProductEvent {
  const FetchAllProductsEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class ChangeSelectedProduct extends ProductEvent {
  ChangeSelectedProduct({required this.label});
  String label;
  @override
  List<Object> get props => [label];
}

class FetchMensApparelEvent extends ProductEvent {
  const FetchMensApparelEvent();

  @override
  List<Object> get props => [];
}

class FetchWomensApparelEvent extends ProductEvent {
  const FetchWomensApparelEvent();

  @override
  List<Object> get props => [];
}

class FetchKidsApparelEvent extends ProductEvent {
  const FetchKidsApparelEvent();

  @override
  List<Object> get props => [];
}

class FetchKidsFootWearEvent extends ProductEvent {
  const FetchKidsFootWearEvent();

  @override
  List<Object> get props => [];
}

class FetchMensFootWearEvent extends ProductEvent {
  const FetchMensFootWearEvent();

  @override
  List<Object> get props => [];
}

class FetchWomensFootWearEvent extends ProductEvent {
  const FetchWomensFootWearEvent();

  @override
  List<Object> get props => [];
}

class FetchNutritionEvent extends ProductEvent {
  const FetchNutritionEvent();

  @override
  List<Object> get props => [];
}

class FetchAccessoriesEvent extends ProductEvent {
  const FetchAccessoriesEvent();

  @override
  List<Object> get props => [];
}
