// lib/features/alimento/provider/food_provider.dart
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/food_item.dart';

class FoodProvider extends ChangeNotifier {
  late final Box<FoodItem> _box;
  List<FoodItem> _foods = [];

  List<FoodItem> get foods => _foods;

  FoodProvider() {
    _box = Hive.box<FoodItem>('foods');
    _loadFoods();
  }

  void _loadFoods() {
    _foods = _box.values.toList();
    notifyListeners();
  }

  void addFood(FoodItem item) {
    _box.add(item);
    _loadFoods();
  }

  void removeFoodAt(int index) {
    _box.deleteAt(index);
    _loadFoods();
  }

  void createFood({
    required String name,
    required int calories,
    required String description,
    String? imagePath,
  }) {
    final food = FoodItem(
      name: name,
      calories: calories,
      description: description,
      imagePath: imagePath,
    );
    _box.add(food);
    _loadFoods();
  }
}
