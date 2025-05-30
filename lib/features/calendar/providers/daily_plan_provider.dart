import 'package:flutter/material.dart';
import 'package:food_planner_app/features/alimento/models/daily_plan.dart';
import 'package:food_planner_app/features/alimento/models/meal.dart';
import 'package:hive/hive.dart';

class DailyPlanProvider extends ChangeNotifier {
  late final Box<DailyPlan> _box;
  List<DailyPlan> _plans = [];

  DailyPlanProvider() {
    _box = Hive.box<DailyPlan>('plans');
    _loadPlans();
  }

  void _loadPlans() {
    _plans = _box.values.toList();
    notifyListeners();
  }

  DailyPlan getPlan(DateTime date) {
    final key = _dateKey(date);

    // 1) Si existe en Hive, lo cargamos
    if (_box.containsKey(key)) {
      final existing = _box.get(key)!;
      // Aseguramos estar en la lista en memoria
      if (!_plans.any((p) => _isSameDate(p.date, date))) {
        _plans.add(existing);
      }
      return existing;
    }

    // 2) Si no existe, creamos y guardamos con put(key,…)
    final newPlan = DailyPlan(
      date: date,
      meals: [
        Meal(type: 'Desayuno'),
        Meal(type: 'Almuerzo'),
        Meal(type: 'Cena'),
      ],
    );
    _box.put(key, newPlan);
    _plans.add(newPlan);
    notifyListeners();
    return newPlan;
  }

  void savePlan(DailyPlan plan) {
    final key = _dateKey(plan.date);
    // Esto actualizará o insertará siempre bajo la misma key
    _box.put(key, plan);

    // Actualizamos la lista en memoria
    final idx = _plans.indexWhere((p) => _isSameDate(p.date, plan.date));
    if (idx != -1) {
      _plans[idx] = plan;
    } else {
      _plans.add(plan);
    }
    notifyListeners();
  }

  String _dateKey(DateTime date) =>
      '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
