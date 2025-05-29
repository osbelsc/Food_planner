import 'package:hive/hive.dart';

part 'food_item.g.dart';

@HiveType(typeId: 0)
class FoodItem extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  int calories;

  @HiveField(2)
  String description;

  @HiveField(3)
  String? imagePath;

  FoodItem({
    required this.name,
    required this.calories,
    required this.description,
    this.imagePath,
  });
}
