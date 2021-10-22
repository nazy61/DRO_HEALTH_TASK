part of 'navbar_cubit.dart';

abstract class NavbarState extends Equatable {
  const NavbarState();

  @override
  List<Object> get props => [];

  get currentIndex => null;
}

class NavbarInitial extends NavbarState {
  @override
  final int currentIndex;
  const NavbarInitial(this.currentIndex);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NavbarInitial && other.currentIndex == currentIndex;
  }

  @override
  int get hashCode => currentIndex.hashCode;
}

class NavbarChanged extends NavbarState {
  @override
  final int currentIndex;
  const NavbarChanged(this.currentIndex);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NavbarChanged && other.currentIndex == currentIndex;
  }

  @override
  int get hashCode => currentIndex.hashCode;
}
