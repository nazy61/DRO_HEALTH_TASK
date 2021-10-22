part of 'scroll_cubit.dart';

abstract class ScrollState extends Equatable {
  const ScrollState();

  @override
  List<Object> get props => [];

  get isScrollDown => null;
}

class ScrollInitial extends ScrollState {
  @override
  final bool isScrollDown;
  const ScrollInitial(this.isScrollDown);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScrollInitial && other.isScrollDown == isScrollDown;
  }

  @override
  int get hashCode => isScrollDown.hashCode;
}

class ScrollChanged extends ScrollState {
  @override
  final bool isScrollDown;
  const ScrollChanged(this.isScrollDown);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScrollChanged && other.isScrollDown == isScrollDown;
  }

  @override
  int get hashCode => isScrollDown.hashCode;
}
