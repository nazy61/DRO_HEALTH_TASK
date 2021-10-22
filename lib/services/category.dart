import '../database/database.dart';
import '../models/category.dart';
import '../utils/utils.dart';

abstract class CategoryRepository {
  /// Throws [NetworkException].
  Future<List<Category>> fetchCategory();
}

class FakeCategoryRepository implements CategoryRepository {
  @override
  Future<List<Category>> fetchCategory() {
    // Simulate network delay
    return Future.delayed(
      const Duration(seconds: 5),
      () {
        return Database.categories;
      },
    );
  }
}
