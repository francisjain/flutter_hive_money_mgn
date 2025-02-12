import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/category/category_models.dart';

const CATEGORY_DB_NAME = 'category-db';

abstract class CategoryDbFunction {
  Future<List<CategoryModels>> getCategories();
  Future<void> insertCategory(CategoryModels value);
  Future<void> deleteCategory(String value);
}

class CategoryDb implements CategoryDbFunction {
  CategoryDb._internal();

  static CategoryDb instance = CategoryDb._internal();

  factory CategoryDb() {
    return instance;
  }

  ValueNotifier<List<CategoryModels>> IncomeCategoryListNotifier =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModels>> ExpenseCategoryListNotifier =
      ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModels value) async {
    final _categoryDb = await Hive.openBox<CategoryModels>(CATEGORY_DB_NAME);
    await _categoryDb.put(value.id, value);
    refreashUI();
  }

  @override
  Future<List<CategoryModels>> getCategories() async {
    final _categoryDb = await Hive.openBox<CategoryModels>(CATEGORY_DB_NAME);
    return _categoryDb.values.toList();
  }

  Future<void> refreashUI() async {
    final _allCategories = await getCategories();
    IncomeCategoryListNotifier.value.clear();
    ExpenseCategoryListNotifier.value.clear();

    await Future.forEach(_allCategories, (item) {
      if (item.type == CategoryType.income) {
        IncomeCategoryListNotifier.value.add(item);
      } else {
        ExpenseCategoryListNotifier.value.add(item);
      }
    });

    IncomeCategoryListNotifier.notifyListeners();
    ExpenseCategoryListNotifier.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String value) async {
    final _categoryDb = Hive.box<CategoryModels>(CATEGORY_DB_NAME);
    print(value);
    await _categoryDb.delete(value);
    refreashUI();
  }
}
