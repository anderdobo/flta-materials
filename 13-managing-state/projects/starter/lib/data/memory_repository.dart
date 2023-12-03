import 'dart:core';
import 'package:flutter/foundation.dart';
// 1
import 'repository.dart';
// 2
import 'models/models.dart';

// 3
class MemoryRepository extends Repository with ChangeNotifier {
// 4
  final List<Recipe> _currentRecipes = <Recipe>[];
// 5
  final List<Ingredient> _currentIngredients = <Ingredient>[];
// TODO: Add find methods
// TODO: Add insert methods
// TODO: Add delete methods
// 6
  @override
  Future init() {
    return Future.value(null);
  }

  @override
  void close() {}
}
