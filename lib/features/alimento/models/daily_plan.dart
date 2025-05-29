// lib/models/daily_plan.dart
import 'package:hive/hive.dart';
import 'meal.dart';

part 'daily_plan.g.dart';

@HiveType(typeId: 2)
class DailyPlan extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  List meals;

  DailyPlan({required this.date, List? meals}) : meals = meals ?? [];
}
