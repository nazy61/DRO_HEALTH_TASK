import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchInitial(false, false));

  void searchChanged(String keyword) {
    if (keyword.isNotEmpty) {
      emit(const SearchChanged(true, false));
    } else {
      emit(const SearchChanged(false, false));
    }
  }

  void searchByCategory(String keyword) {
    if (keyword.isNotEmpty) {
      emit(const SearchChanged(false, true));
    } else {
      emit(const SearchChanged(false, false));
    }
  }
}
