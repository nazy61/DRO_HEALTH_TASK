import 'package:dro_health/cubit/cubits.dart';
import 'package:dro_health/database/database.dart';
import 'package:dro_health/services/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';

void main() {
  group('ProductCubit test', () {
    late ProductCubit productCubit;
    FakeProductRepository productRepository;

    setUp(() {
      EquatableConfig.stringify = true;
      productRepository = FakeProductRepository();
      productCubit = ProductCubit(productRepository);
    });

    blocTest<ProductCubit, ProductState>(
      "emits [ProductLoading, ProductLoaded] states for loading of products",
      build: () => productCubit,
      act: (cubit) => cubit.getProduct(),
      expect: () => [
        const ProductLoading(),
        const ProductLoaded(Database.products),
      ],
    );

    blocTest<ProductCubit, ProductState>(
      "emits [ProductLoading, ProductLoaded] states for searching of products",
      build: () => productCubit,
      act: (cubit) => cubit.searchProduct("para"),
      expect: () => [
        const ProductLoading(),
        isA<ProductLoaded>(),
      ],
    );

    // blocTest<ProductCubit, ProductState>(
    //   "emits [ProductLoading, ProductLoaded] states for searching of products by category",
    //   build: () => productCubit,
    //   act: (cubit) => cubit.searchProductByCategory("headache"),
    //   expect: () => [
    //     const ProductLoading(),
    //     isA<ProductLoaded>(),
    //   ],
    // );

    blocTest<ProductCubit, ProductState>(
      "emits [ProductLoading, ProductLoaded] states for fetching of similar of products",
      build: () => productCubit,
      act: (cubit) => cubit.fetchSimilarProducts(1),
      expect: () => [
        const ProductLoading(),
        isA<ProductLoaded>(),
      ],
    );

    blocTest<ProductCubit, ProductState>(
      "emits [ProductLoading, ProductLoaded] states for searching of products",
      build: () => productCubit,
      act: (cubit) => cubit.searchProduct("para"),
      expect: () => [
        const ProductLoading(),
        isA<ProductLoaded>(),
      ],
    );

    tearDown(() {
      productCubit.close();
    });
  });
}
