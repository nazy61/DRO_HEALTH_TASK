import 'package:dro_health/cubit/cubits.dart';
import 'package:dro_health/database/database.dart';
import 'package:dro_health/services/services.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';

void main() {
  group('ScrollCubit test', () {
    late ScrollCubit scrollCubit;

    setUp(() {
      EquatableConfig.stringify = true;
      scrollCubit = ScrollCubit();
    });

    blocTest<ScrollCubit, ScrollState>(
      "emits [ScrollChanged] states for getting scroll direction",
      build: () => scrollCubit,
      act: (cubit) => cubit.changedScrollDirection(ScrollDirection.forward),
      expect: () => [const ScrollChanged(false)],
    );

    blocTest<ScrollCubit, ScrollState>(
      "emits [ScrollChanged] states for getting scroll direction",
      build: () => scrollCubit,
      act: (cubit) => cubit.changedScrollDirection(ScrollDirection.reverse),
      expect: () => [const ScrollChanged(true)],
    );

    tearDown(() {
      scrollCubit.close();
    });
  });
}
