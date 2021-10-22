import 'package:dro_health/cubit/cubits.dart';
import 'package:dro_health/database/database.dart';
import 'package:dro_health/services/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';

void main() {
  group('CategoryCubit test', () {
    late CategoryCubit categoryCubit;
    FakeCategoryRepository categoryRepository;

    setUp(() {
      EquatableConfig.stringify = true;
      categoryRepository = FakeCategoryRepository();
      categoryCubit = CategoryCubit(categoryRepository);
    });

    blocTest<CategoryCubit, CategoryState>(
      "emits [CategoryLoading, CategoryLoaded] states for getting all categories",
      build: () => categoryCubit,
      act: (cubit) => cubit.getCategory(),
      expect: () => [
        const CategoryLoading(),
        const CategoryLoaded(Database.categories),
      ],
    );

    tearDown(() {
      categoryCubit.close();
    });
  });
}
