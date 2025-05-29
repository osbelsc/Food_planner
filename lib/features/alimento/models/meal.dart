import 'package:hive/hive.dart';
import 'food_item.dart';

part 'meal.g.dart';

@HiveType(typeId: 1)
class Meal extends HiveObject {
  @HiveField(0)
  String type; // desayuno, almuerzo, cena

  @HiveField(1)
  List<FoodItem> items;

  Meal({required this.type, List<FoodItem>? items}) : items = items ?? [];
}
