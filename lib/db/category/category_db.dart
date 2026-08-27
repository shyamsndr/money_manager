import 'dart:math';

import 'package:hive_flutter/hive_flutter.dart';

import '../../models/category/category_model.dart';

abstract class CategoryDbFunctions {
  List<CategoryModel> getCategories(CategoryType type);

  Future<void> insertCategory(CategoryModel category);

  Future<void> deleteCategory(int id);

  int getNextId();
}

class CategoryDbFunctionsImpl implements CategoryDbFunctions {
  // Open categories box
  final box = Hive.box<CategoryModel>('categories');

  // GET
  @override
  List<CategoryModel> getCategories(CategoryType type) {
    return box.values
        .where(
          (category) => category.type == type && category.isDeleted == false,
        )
        .toList();
  }

  // INSERT
  @override
  Future<void> insertCategory(CategoryModel category) async {
    await box.put(category.id, category);
  }

  // SOFT DELETE
  @override
  Future<void> deleteCategory(int id) async {
    final category = box.get(id);

    if (category == null) {
      return;
    }

    final updatedCategory = CategoryModel(
      id: category.id,
      name: category.name,
      type: category.type,
      isDeleted: true,
    );

    await box.put(id, updatedCategory);
  }

  // GET NEXT ID
  @override
  int getNextId() {
    if (box.isEmpty) {
      return 1;
    }

    final ids = box.keys.cast<int>();

    return ids.reduce(max) + 1;
  }
}
