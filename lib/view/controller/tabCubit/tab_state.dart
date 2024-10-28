part of 'tab_cubit.dart';

class TabState extends Equatable{
  final int index;

   const TabState({required this.index});

  TabState copyWith({int? index})
  {
    return TabState(index: index??this.index);
  }

  @override
  List<Object?> get props => [index];
}

