import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synew_gym/blocs/tab_bar/tab_bar_state.dart';

class TabBarCubit extends Cubit<TabBarState> {
  TabBarCubit() : super(TabBarState.initial());

  void tabBarPressed(int index) {
    emit(state.copyWith(index: index));
  }
}
