import 'package:food_planner_app/features/alimento/models/food_item.dart';
import 'package:hive/hive.dart';

part 'recipe.g.dart';

@HiveType(typeId: 1)
class Recipe extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<FoodItem> items;

  Recipe({required this.name, required this.items});
}
