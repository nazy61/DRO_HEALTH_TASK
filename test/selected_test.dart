import 'package:dro_health/cubit/cubits.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';

void main() {
  group('SelectedCategoryCubit test', () {
    late SelectedCategoryCubit selectedCategoryCubit;

    setUp(() {
      EquatableConfig.stringify = true;
      selectedCategoryCubit = SelectedCategoryCubit();
    });

    blocTest<SelectedCategoryCubit, SelectedCategoryState>(
      "emits [SelectedCategory] states for getting selected categories",
      build: () => selectedCategoryCubit,
      act: (cubit) => cubit.categorySelected("Chinaza"),
      expect: () => [const SelectedCategory("Chinaza")],
    );

    tearDown(() {
      selectedCategoryCubit.close();
    });
  });
}
