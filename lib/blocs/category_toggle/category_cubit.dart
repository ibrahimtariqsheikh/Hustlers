import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synew_gym/blocs/category_toggle/category_state.dart';
import 'package:synew_gym/blocs/product/product_bloc.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final ProductBloc productBloc;

  CategoryCubit({required this.productBloc}) : super(CategoryState.initial());

  void categoryButtonPressed(int index, String label) {
    productBloc.add(ChangeSelectedProduct(label: label));
    emit(state.copyWith(index: index));
  }
}
