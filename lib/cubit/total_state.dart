part of 'total_cubit.dart';

abstract class TotalState extends Equatable {
  const TotalState();

  @override
  List<Object> get props => [];

  get total => 0;
}

class TotalInitial extends TotalState {
  @override
  final double total;
  const TotalInitial(this.total);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TotalInitial && other.total == total;
  }

  @override
  int get hashCode => total.hashCode;
}

class TotalCalculated extends TotalState {
  @override
  final double total;
  const TotalCalculated(this.total);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TotalCalculated && other.total == total;
  }

  @override
  int get hashCode => total.hashCode;
}
