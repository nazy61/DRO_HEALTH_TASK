import 'package:dro_health/cubit/cubits.dart';
import 'package:dro_health/database/database.dart';
import 'package:dro_health/services/services.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';

void main() {
  group('SearchCubit test', () {
    late SearchCubit searchCubit;

    setUp(() {
      EquatableConfig.stringify = true;
      searchCubit = SearchCubit();
    });

    blocTest<SearchCubit, SearchState>(
      "emits [SearchChanged] states for toggling searching ui",
      build: () => searchCubit,
      act: (cubit) => cubit.searchChanged("d"),
      expect: () => [const SearchChanged(true, false)],
    );

    blocTest<SearchCubit, SearchState>(
      "emits [SearchChanged] states for toggling searching ui",
      build: () => searchCubit,
      act: (cubit) => cubit.searchChanged(""),
      expect: () => [const SearchChanged(false, false)],
    );

    blocTest<SearchCubit, SearchState>(
      "emits [SearchChanged] states for toggling searching by category ui",
      build: () => searchCubit,
      act: (cubit) => cubit.searchByCategory("h"),
      expect: () => [const SearchChanged(false, true)],
    );

    blocTest<SearchCubit, SearchState>(
      "emits [SearchChanged] states for toggling searching by category ui",
      build: () => searchCubit,
      act: (cubit) => cubit.searchByCategory(""),
      expect: () => [const SearchChanged(false, false)],
    );

    tearDown(() {
      searchCubit.close();
    });
  });
}
