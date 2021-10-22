part of 'quantity_cubit.dart';

abstract class QuantityState extends Equatable {
  const QuantityState();

  @override
  List<Object> get props => [];

  get quantity => null;
}

class QuantityInitial extends QuantityState {
  @override
  final int quantity;
  const QuantityInitial(this.quantity);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuantityInitial && other.quantity == quantity;
  }

  @override
  int get hashCode => quantity.hashCode;
}

class QuantityIncreased extends QuantityState {
  @override
  final int quantity;
  const QuantityIncreased(this.quantity);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuantityIncreased && other.quantity == quantity;
  }

  @override
  int get hashCode => quantity.hashCode;
}

class QuantityDecreased extends QuantityState {
  @override
  final int quantity;
  const QuantityDecreased(this.quantity);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QuantityDecreased && other.quantity == quantity;
  }

  @override
  int get hashCode => quantity.hashCode;
}
