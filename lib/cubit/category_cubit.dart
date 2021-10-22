import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../services/services.dart';
import '../utils/utils.dart';
import '../models/models.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository _categoryRepository;

  CategoryCubit(this._categoryRepository) : super(const CategoryInitial());

  Future<void> getCategory() async {
    try {
      emit(const CategoryLoading());
      final category = await _categoryRepository.fetchCategory();
      emit(CategoryLoaded(category));
    } on NetworkException {
      emit(
        const CategoryError("Couldn't fetch categories. Is the device online?"),
      );
    }
  }
}
