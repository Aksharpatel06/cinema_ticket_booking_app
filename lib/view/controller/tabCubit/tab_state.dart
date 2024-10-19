part of 'tab_cubit.dart';

class TabState extends Equatable{
  int index;

  TabState({this.index=0});
  @override
  List<Object?> get props => [index];
}

