import 'package:dro_health/models/product.dart';
import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final int id;
  final Product product;
  final int qty;

  const CartItem({
    required this.id,
    required this.product,
    required this.qty,
  });

  @override
  List<Object> get props => [id, product, qty];

  @override
  bool get stringify => false;
}
