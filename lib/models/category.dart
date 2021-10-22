import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final String imageURL;

  const Category({
    required this.id,
    required this.name,
    required this.imageURL,
  });

  @override
  List<Object> get props => [id, name, imageURL];

  @override
  bool get stringify => false;
}
