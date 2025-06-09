import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/recipe.dart';
import '../../alimento/models/food_item.dart';

class RecipeProvider extends ChangeNotifier {
  late final Box<Recipe> _box;

  String _tempName = '';
  final List<FoodItem> _tempItems = [];

  List<Recipe> _recipes = [];
  List<Recipe> get recipes => _recipes;
  List<FoodItem> get tempItems => List.unmodifiable(_tempItems);
  String? _tempImagePath;

  RecipeProvider() {
    _box = Hive.box<Recipe>('recipes');
    _loadRecipes();
  }

  void _loadRecipes() {
    _recipes = _box.values.toList();
    notifyListeners();
  }

  void updateTempImagePath(String? path) {
    _tempImagePath = path;
  }

  void updateTempName(String name) {
    _tempName = name.trim();
  }

  void removeRecipeAt(int index) {
    _box.deleteAt(index);
    _loadRecipes();
  }

  void addTempItem(FoodItem item) {
    _tempItems.add(item);
    notifyListeners();
  }

  void saveTempRecipe() {
    if (_tempName.isNotEmpty && _tempItems.isNotEmpty) {
      final recipe = Recipe(
        name: _tempName,
        items: List.from(_tempItems),
        imagePath: _tempImagePath,
      );
      _box.add(recipe);
      _loadRecipes();
    }
    _resetTempData();
  }

  void _resetTempData() {
    _tempName = '';
    _tempItems.clear();
    notifyListeners();
  }

  void deleteRecipe(int index) {
    _box.deleteAt(index);
    _loadRecipes();
  }
}
