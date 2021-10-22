import 'package:dro_health/cubit/cubits.dart';
import 'package:dro_health/database/database.dart';
import 'package:dro_health/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';

List<CartItem> cartItems = [
  CartItem(
    id: 1,
    product: Database.products[1],
    qty: 1,
  ),
  CartItem(
    id: 2,
    product: Database.products[1],
    qty: 4,
  ),
  CartItem(
    id: 3,
    product: Database.products[1],
    qty: 5,
  ),
];

void main() {
  group('CartCubit test', () {
    late CartCubit cartCubit;

    setUp(() {
      EquatableConfig.stringify = true;
      cartCubit = CartCubit();
    });

    // blocTest<CartCubit, CartState>(
    //   "emits [CartLoading, CartLoaded] states for successful getting of cart items",
    //   build: () => cartCubit,
    //   seed: () {
    //     CartInitial state = CartInitial(cartItems);
    //     return state;
    //   },
    //   act: (cubit) => cubit.getCartItems(),
    //   expect: () => [
    //     const CartLoading(),
    //     const CartLoaded([]),
    //   ],
    // );
    blocTest<CartCubit, CartState>(
      "emits [CartLoaded] states for successful addition to cart",
      build: () => cartCubit,
      seed: () {
        CartInitial state = CartInitial(cartItems);
        return state;
      },
      act: (cubit) => cubit.addToCart(
        product: Database.products[4],
        qty: 1,
      ),
      expect: () => [isA<CartLoaded>()],
    );

    blocTest<CartCubit, CartState>(
      "emits [CartLoaded] states for successful removal from cart",
      build: () => cartCubit,
      seed: () {
        CartInitial state = CartInitial(cartItems);
        return state;
      },
      act: (cubit) => cubit.removeFromCart(
        cartItems[0],
      ),
      expect: () => [isA<CartLoaded>()],
    );

    blocTest<CartCubit, CartState>(
      "emits [CartLoaded] states for successful update of cart item",
      build: () => cartCubit,
      seed: () {
        CartInitial state = CartInitial(cartItems);
        return state;
      },
      act: (cubit) {
        cubit.updateCartItem(
          cartItems[0],
          "3",
        );
      },
      expect: () => [isA<CartLoaded>()],
    );

    tearDown(() {
      cartCubit.close();
    });
  });
}
