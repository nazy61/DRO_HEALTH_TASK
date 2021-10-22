import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/models.dart';
import '../services/services.dart';
import '../utils/utils.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _productRepository;

  ProductCubit(this._productRepository) : super(const ProductInitial());

  Future<void> getProduct() async {
    try {
      emit(const ProductLoading());
      final product = await _productRepository.fetchProduct();
      emit(ProductLoaded(product));
    } on NetworkException {
      emit(
        const ProductError("Couldn't fetch products. Is the device online?"),
      );
    }
  }

  Future<void> searchProduct(String keyword) async {
    try {
      emit(const ProductLoading());
      final product = await _productRepository.searchProduct(keyword);
      emit(ProductLoaded(product));
    } on NetworkException {
      emit(
        const ProductError("No Products Found"),
      );
    }
  }

  Future<void> searchProductByCategory(String keyword) async {
    try {
      emit(const ProductLoading());
      final product = await _productRepository.searchProductByCategory(keyword);
      if (product.isEmpty) {
        emit(const ProductLoading());
      } else {
        emit(ProductLoaded(product));
      }
    } on NetworkException {
      emit(
        const ProductError("No Products Found"),
      );
    }
  }

  Future<void> fetchSimilarProducts(int categoryId) async {
    try {
      emit(const ProductLoading());
      final product = await _productRepository.fetchSimilarProducts(categoryId);
      emit(ProductLoaded(product));
    } on NetworkException {
      emit(
        const ProductError("No Products Found"),
      );
    }
  }

  Future<void> favoriteProduct(int id) async {
    List<Product> products = state.product;

    Product product = products.firstWhere((element) => element.id == id);

    int index = products.indexOf(product);

    print(index);
  }
}
