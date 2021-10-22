import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String imageURL;
  final String type;
  final int size;
  final double price;
  final int categoryId;
  final bool requiresPrescription;
  final String soldBy;
  final String soldByImageURL;
  final bool isFavourite;
  final String dispensedIn;
  final String constituents;
  final String productId;
  final String packSize;
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.imageURL,
    required this.type,
    required this.size,
    required this.price,
    required this.categoryId,
    required this.requiresPrescription,
    required this.soldBy,
    required this.soldByImageURL,
    required this.isFavourite,
    required this.dispensedIn,
    required this.constituents,
    required this.productId,
    required this.packSize,
    required this.description,
  });

  @override
  List<Object> get props => [
        id,
        name,
        imageURL,
        type,
        size,
        price,
        categoryId,
        requiresPrescription,
      ];

  @override
  bool get stringify => false;
}
