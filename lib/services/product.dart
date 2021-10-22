import 'dart:math';

import '../utils/utils.dart';
import '../database/database.dart';
import '../models/product.dart';

abstract class ProductRepository {
  /// Throws [NetworkException].
  Future<List<Product>> fetchProduct();
  Future<List<Product>> searchProduct(String keyword);
  Future<List<Product>> searchProductByCategory(String keyword);
  Future<List<Product>> fetchSimilarProducts(int categoryId);
}

class FakeProductRepository implements ProductRepository {
  @override
  Future<List<Product>> fetchProduct() {
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        final random = Random();

        // Simulate some network exception
        // if (random.nextBool()) {
        //   throw NetworkException();
        // }

        return Database.products;
      },
    );
  }

  @override
  Future<List<Product>> searchProduct(String keyword) {
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        final random = Random();

        // Simulate some network exception
        // if (random.nextBool()) {
        //   throw NetworkException();
        // }

        var searchResult = Database.products
            .where(
              (element) => element.name.toLowerCase().contains(keyword),
            )
            .toList();

        return searchResult;
      },
    );
  }

  @override
  Future<List<Product>> searchProductByCategory(String keyword) {
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        final random = Random();

        // Simulate some network exception
        // if (random.nextBool()) {
        //   throw NetworkException();
        // }

        if (keyword.isEmpty) {
          var searchResult = Database.products
              .where(
                (element) => element.name.toLowerCase().contains(keyword),
              )
              .toList();

          return [];
        } else {
          var category = Database.categories.firstWhere(
            (element) => element.name == keyword,
          );

          var searchResult = Database.products
              .where(
                (element) => element.categoryId == category.id,
              )
              .toList();

          return searchResult;
        }
      },
    );
  }

  @override
  Future<List<Product>> fetchSimilarProducts(int categoryId) {
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        var searchResult = Database.products
            .where(
              (element) => element.categoryId == categoryId,
            )
            .toList();

        return searchResult;
      },
    );
  }
}
