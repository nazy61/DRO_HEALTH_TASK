part of 'selected_category_cubit.dart';

abstract class SelectedCategoryState extends Equatable {
  const SelectedCategoryState();

  @override
  List<Object> get props => [];
  get name => null;
}

class SelectedCategoryInitial extends SelectedCategoryState {
  @override
  final String? name;
  const SelectedCategoryInitial(this.name);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SelectedCategoryInitial && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

class SelectedCategory extends SelectedCategoryState {
  @override
  final String name;
  const SelectedCategory(this.name);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SelectedCategory && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
