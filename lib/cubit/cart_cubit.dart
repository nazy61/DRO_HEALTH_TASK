import 'package:bloc/bloc.dart';
import 'package:dro_health/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartInitial([]));

  void getCartItems() async {
    emit(const CartLoading());
    List<CartItem> cartItems = await Future.delayed(
      const Duration(seconds: 2),
      () {
        return state.cartItems;
      },
    );
    emit(CartLoaded(cartItems));
  }

  void addToCart({required Product product, required int qty}) {
    int id;
    List<CartItem> cartItems = [];

    if (state.cartItems != null) {
      id = state.cartItems.length + 1;
      cartItems = [...state.cartItems];
    } else {
      id = 1;
    }

    CartItem cartItem = CartItem(
      id: id,
      product: product,
      qty: qty,
    );

    var itemFound = cartItems
        .firstWhereOrNull((element) => element.product.id == product.id);

    if (itemFound == null) {
      cartItems.add(cartItem);
    }

    emit(CartLoaded(cartItems));
  }

  void removeFromCart(CartItem cartItem) {
    List<CartItem> cartItems = [...state.cartItems];

    int index = cartItems.indexOf(cartItem);

    cartItems.removeAt(index);

    emit(CartLoaded(cartItems));
  }

  void updateCartItem(CartItem cartItem, String? qty) {
    List<CartItem> cartItems = [...state.cartItems];

    int index = cartItems.indexOf(cartItem);

    CartItem updatedCartItem = CartItem(
      id: cartItem.id,
      product: cartItem.product,
      qty: int.parse(qty.toString()),
    );

    cartItems[index] = updatedCartItem;

    emit(CartLoaded(cartItems));
  }
}
