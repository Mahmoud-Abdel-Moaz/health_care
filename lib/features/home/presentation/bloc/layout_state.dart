part of 'layout_cubit.dart';

abstract class LayoutState extends Equatable {
  const LayoutState();
}

class LayoutInitial extends LayoutState {
  @override
  List<Object> get props => [];
}


class ChangeCurrentPageState extends LayoutState {
  final int index;

  const ChangeCurrentPageState(this.index);
  @override
  List<Object> get props => [index];
}
