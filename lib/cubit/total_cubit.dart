import 'package:bloc/bloc.dart';
import 'package:dro_health/models/models.dart';
import 'package:equatable/equatable.dart';

part 'total_state.dart';

class TotalCubit extends Cubit<TotalState> {
  TotalCubit() : super(const TotalInitial(0));

  void calculateTotal(List<CartItem> cartItems) {
    double total = 0;

    for (var cartItem in cartItems) {
      double price = cartItem.product.price * cartItem.qty;

      total += price;
    }

    emit(TotalCalculated(total));
  }
}
