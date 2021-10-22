import 'package:dro_health/cubit/cubits.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';

void main() {
  group('NavbarCubit test', () {
    late NavbarCubit navbarCubit;

    setUp(() {
      EquatableConfig.stringify = true;
      navbarCubit = NavbarCubit();
    });

    blocTest<NavbarCubit, NavbarState>(
      "emits [NavbarChanged] states for tapping on a navbar icon",
      build: () => navbarCubit,
      act: (cubit) => cubit.changedNavBar(2),
      expect: () => [
        const NavbarChanged(2),
      ],
    );

    tearDown(() {
      navbarCubit.close();
    });
  });
}
