import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';

part 'scroll_state.dart';

class ScrollCubit extends Cubit<ScrollState> {
  ScrollCubit() : super(const ScrollInitial(true));

  void changedScrollDirection(ScrollDirection direction) {
    bool isScrollDown = true;

    if (ScrollDirection.forward == direction) {
      isScrollDown = false;
    } else {
      isScrollDown = true;
    }

    emit(ScrollChanged(isScrollDown));
  }
}
