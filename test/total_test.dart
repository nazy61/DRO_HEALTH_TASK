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
  group('TotalCubit test', () {
    late TotalCubit totalCubit;

    setUp(() {
      EquatableConfig.stringify = true;
      totalCubit = TotalCubit();
    });

    blocTest<TotalCubit, TotalState>(
      "emits [TotalCalculated] states for getting selected categories",
      build: () => totalCubit,
      act: (cubit) => cubit.calculateTotal(cartItems),
      expect: () => [isA<TotalCalculated>()],
    );

    tearDown(() {
      totalCubit.close();
    });
  });
}
