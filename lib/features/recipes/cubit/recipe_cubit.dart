import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_planner_app/features/alimento/models/food_item.dart';
import 'package:food_planner_app/features/recipes/models/recipe.dart';
import 'package:hive/hive.dart';

class RecipeCubit extends Cubit<List<Recipe>> {
  late final Box<Recipe> _box;

  String _tempName = '';
  List<FoodItem> _tempItems = [];

  RecipeCubit() : super([]) {
    _box = Hive.box<Recipe>('recipes');
    emit(_box.values.toList());
  }

  void updateTempName(String name) {
    _tempName = name.trim();
  }

  void addTempItem(FoodItem item) {
    _tempItems.add(item);
  }

  List<FoodItem> get tempItems => List.unmodifiable(_tempItems);

  void saveTempRecipe() {
    if (_tempName.isNotEmpty && _tempItems.isNotEmpty) {
      final recipe = Recipe(name: _tempName, items: _tempItems);
      _box.add(recipe);
      emit(_box.values.toList());
    }
    _resetTempData();
  }

  void _resetTempData() {
    _tempName = '';
    _tempItems = [];
  }

  void deleteRecipe(int index) {
    _box.deleteAt(index);
    emit(_box.values.toList());
  }
}
