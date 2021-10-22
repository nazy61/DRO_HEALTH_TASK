import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'selected_category_state.dart';

class SelectedCategoryCubit extends Cubit<SelectedCategoryState> {
  SelectedCategoryCubit() : super(const SelectedCategoryInitial(null));

  void categorySelected(String name) {
    emit(SelectedCategory(name));
  }
}
