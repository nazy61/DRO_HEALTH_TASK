import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'quantity_state.dart';

class QuantityCubit extends Cubit<QuantityState> {
  QuantityCubit() : super(const QuantityInitial(1));

  void quantityIncreased() {
    if (state.quantity == 8) {
      emit(QuantityIncreased(state.quantity));
    } else {
      emit(QuantityIncreased(state.quantity + 1));
    }
  }

  void quantityDecreased() {
    if (state.quantity > 1) {
      emit(QuantityIncreased(state.quantity - 1));
    } else {
      emit(const QuantityDecreased(0));
    }
  }
}
