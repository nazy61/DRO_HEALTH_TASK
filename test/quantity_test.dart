import 'package:dro_health/cubit/cubits.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';

void main() {
  group('QuantityCubit test', () {
    late QuantityCubit quantityCubit;

    setUp(() {
      EquatableConfig.stringify = true;
      quantityCubit = QuantityCubit();
    });

    blocTest<QuantityCubit, QuantityState>(
      "emits [QuantityIncreased] states for increasing quantity",
      build: () => quantityCubit,
      seed: () {
        QuantityInitial state = const QuantityInitial(1);
        return state;
      },
      act: (cubit) => cubit.quantityIncreased(),
      expect: () => [const QuantityIncreased(2)],
    );

    blocTest<QuantityCubit, QuantityState>(
      "emits [QuantityDecreased] states for decreasing quantity",
      build: () => quantityCubit,
      seed: () {
        QuantityInitial state = const QuantityInitial(3);
        return state;
      },
      act: (cubit) => cubit.quantityDecreased(),
      expect: () => [const QuantityDecreased(2)],
    );

    tearDown(() {
      quantityCubit.close();
    });
  });
}
