part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];

  get product => null;
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductLoaded extends ProductState {
  @override
  final List<Product> product;
  const ProductLoaded(this.product);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductLoaded && other.product == product;
  }

  @override
  int get hashCode => product.hashCode;
}

class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
