import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tab_state.dart';

class TabCubit extends Cubit<TabState> {
  TabCubit() : super( const TabState(index: 0));

  void changeTab() {
    int newIndex = (state.index + 1) % 2;
    emit(state.copyWith(index: newIndex));
    log('change tab');
  }
}
