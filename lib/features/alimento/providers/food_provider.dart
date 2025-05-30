// lib/features/alimento/providers/food_provider.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import '../models/food_item.dart';

class FoodProvider extends ChangeNotifier {
  late final Box<FoodItem> _box;
  List<FoodItem> _foods = [];
  File? _selectedImage;

  List<FoodItem> get foods => _foods;
  File? get selectedImage => _selectedImage;

  FoodProvider() {
    _box = Hive.box<FoodItem>('foods');
    _loadFoods();
  }

  void _loadFoods() {
    _foods = _box.values.toList();
    notifyListeners();
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      _selectedImage = File(picked.path);
      notifyListeners();
    }
  }

  Future<void> createFood({
    required String name,
    required int calories,
    required String description,
  }) async {
    final food = FoodItem(
      name: name,
      calories: calories,
      description: description,
      imagePath: _selectedImage?.path,
    );
    await _box.add(food);
    _selectedImage = null;
    _loadFoods();
  }

  void removeFoodAt(int index) {
    _box.deleteAt(index);
    _loadFoods();
  }
}
