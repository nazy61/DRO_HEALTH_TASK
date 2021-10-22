import 'package:dro_health/cubit/cubits.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';

void main() {
  group('BottomSheetCubit test', () {
    late BottomsheetCubit bottomsheetCubit;

    setUp(() {
      EquatableConfig.stringify = true;
      bottomsheetCubit = BottomsheetCubit();
    });

    blocTest<BottomsheetCubit, BottomsheetState>(
      "emits [BottomsheetOpened] states for successful bottomsheet opening",
      build: () => bottomsheetCubit,
      act: (cubit) => cubit.toggle(true),
      expect: () => [
        const BottomsheetOpened(true),
      ],
    );

    blocTest<BottomsheetCubit, BottomsheetState>(
      "emits [BottomsheetClosed] states for successful bottomsheet closed",
      build: () => bottomsheetCubit,
      act: (cubit) => cubit.toggle(false),
      expect: () => [
        const BottomsheetClosed(false),
      ],
    );

    tearDown(() {
      bottomsheetCubit.close();
    });
  });
}
