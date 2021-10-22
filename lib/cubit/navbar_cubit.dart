import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navbar_state.dart';

class NavbarCubit extends Cubit<NavbarState> {
  NavbarCubit() : super(const NavbarInitial(2));

  void changedNavBar(int index) {
    emit(NavbarChanged(index));
  }
}
