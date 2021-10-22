import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottomsheet_state.dart';

class BottomsheetCubit extends Cubit<BottomsheetState> {
  BottomsheetCubit() : super(const BottomsheetOpened(false));

  void toggle(bool value) {
    if (value) {
      emit(const BottomsheetOpened(true));
    } else {
      emit(const BottomsheetClosed(false));
    }
  }
}
