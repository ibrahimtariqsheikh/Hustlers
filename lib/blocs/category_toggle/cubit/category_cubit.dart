import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synew_gym/blocs/category_toggle/cubit/category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryState.initial());

  void categoryButtonPressed(int index, String label) {
    emit(state.copyWith(index: index));
  }
}
