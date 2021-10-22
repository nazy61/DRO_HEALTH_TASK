part of 'category_cubit.dart';

@immutable
abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];

  get category => null;
}

class CategoryInitial extends CategoryState {
  const CategoryInitial();
}

class CategoryLoading extends CategoryState {
  const CategoryLoading();
}

class CategoryLoaded extends CategoryState {
  @override
  final List<Category> category;
  const CategoryLoaded(this.category);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryLoaded && other.category == category;
  }

  @override
  int get hashCode => category.hashCode;
}

class CategoryError extends CategoryState {
  final String message;
  const CategoryError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
