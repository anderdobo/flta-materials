import 'dart:core';
import 'repository.dart';
import 'models/models.dart';
import 'dart:async';

class MemoryRepository extends Repository {
  final List<Recipe> _currentRecipes = <Recipe>[];
  final List<Ingredient> _currentIngredients = <Ingredient>[];

  //1
  Stream<List<Recipe>>? _recipeStream;
  Stream<List<Ingredient>>? _ingredientStream;
// 2
  final StreamController _recipeStreamController =
      StreamController<List<Recipe>>();
  final StreamController _ingredientStreamController =
      StreamController<List<Ingredient>>();

  // 3
  @override
  Stream<List<Recipe>> watchAllRecipes() {
    _recipeStream ??= _recipeStreamController.stream as Stream<List<Recipe>>;
    return _recipeStream!;
  }

// 4
  @override
  Stream<List<Ingredient>> watchAllIngredients() {
    _ingredientStream ??=
        _ingredientStreamController.stream as Stream<List<Ingredient>>;
    return _ingredientStream!;
  }

  @override
// 1
  Future<List<Recipe>> findAllRecipes() {
// 2
    return Future.value(_currentRecipes);
  }

  @override
  Future<Recipe> findRecipeById(int id) {
    return Future.value(
        _currentRecipes.firstWhere((recipe) => recipe.id == id));
  }

  @override
  Future<List<Ingredient>> findAllIngredients() {
    return Future.value(_currentIngredients);
  }

  @override
  Future<List<Ingredient>> findRecipeIngredients(int recipeId) {
    final recipe =
        _currentRecipes.firstWhere((recipe) => recipe.id == recipeId);
    final recipeIngredients = _currentIngredients
        .where((ingredient) => ingredient.recipeId == recipe.id)
        .toList();
    return Future.value(recipeIngredients);
  }

  @override
// 1
  Future<int> insertRecipe(Recipe recipe) {
    _currentRecipes.add(recipe);
// 2
    _recipeStreamController.sink.add(_currentRecipes);
    if (recipe.ingredients != null) {
      insertIngredients(recipe.ingredients!);
    }
// 3
// 4
    return Future.value(0);
  }

  @override
  Future<List<int>> insertIngredients(List<Ingredient> ingredients) {
    _currentIngredients.addAll(ingredients);
    _recipeStreamController.sink.add(_currentIngredients);
    if (ingredients.isNotEmpty) {
      _currentIngredients.addAll(ingredients);
    }
    return Future.value(<int>[]);
  }

  @override
  Future<void> deleteRecipe(Recipe recipe) {
    _currentRecipes.remove(recipe);
    _recipeStreamController.sink.add(_currentRecipes);
    if (recipe.id != null) {
      deleteRecipeIngredients(recipe.id!);
    }
    return Future.value();
  }

  @override
  Future<void> deleteIngredient(Ingredient ingredient) {
    _currentIngredients.remove(ingredient);
    _recipeStreamController.sink.add(_currentIngredients);
    return Future.value();
  }

  @override
  Future<void> deleteIngredients(List<Ingredient> ingredients) {
    _currentIngredients
        .removeWhere((ingredient) => ingredients.contains(ingredient));
    _recipeStreamController.sink.add(_currentIngredients);
    return Future.value();
  }

  @override
  Future<void> deleteRecipeIngredients(int recipeId) {
    _currentIngredients
        .removeWhere((ingredient) => ingredient.recipeId == recipeId);
    _recipeStreamController.sink.add(_currentIngredients);
    return Future.value();
  }

  @override
  Future init() {
    return Future.value();
  }

  @override
  void close() {
    _recipeStreamController.close();
    _ingredientStreamController.close();
  }
}
