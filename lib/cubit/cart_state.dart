part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];

  get cartItems => null;
}

class CartInitial extends CartState {
  @override
  final List<CartItem> cartItems;
  const CartInitial(this.cartItems);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartInitial && other.cartItems == cartItems;
  }

  @override
  int get hashCode => cartItems.hashCode;
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  @override
  final List<CartItem> cartItems;
  const CartLoaded(this.cartItems);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartLoaded && other.cartItems == cartItems;
  }

  @override
  int get hashCode => cartItems.hashCode;
}

class CartError extends CartState {
  const CartError();
}
