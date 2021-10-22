part of 'bottomsheet_cubit.dart';

abstract class BottomsheetState extends Equatable {
  const BottomsheetState();

  @override
  List<Object> get props => [];

  get isOpen => null;
}

class BottomsheetOpened extends BottomsheetState {
  @override
  final bool isOpen;
  const BottomsheetOpened(this.isOpen);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BottomsheetOpened && other.isOpen == isOpen;
  }

  @override
  int get hashCode => isOpen.hashCode;
}

class BottomsheetClosed extends BottomsheetState {
  @override
  final bool isOpen;
  const BottomsheetClosed(this.isOpen);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BottomsheetClosed && other.isOpen == isOpen;
  }

  @override
  int get hashCode => isOpen.hashCode;
}
