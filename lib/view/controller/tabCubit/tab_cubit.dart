import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


part 'tab_state.dart';

class TabCubit extends Cubit<TabState> {
  TabCubit() : super(TabState());
  void changeTab() {
    emit(TabState(index: 1));
  }

}
