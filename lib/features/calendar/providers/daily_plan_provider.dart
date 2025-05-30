// lib/features/alimento/provider/daily_plan_provider.dart
import 'package:flutter/foundation.dart';
import 'package:food_planner_app/features/alimento/models/daily_plan.dart';
import 'package:food_planner_app/features/alimento/models/meal.dart';
import 'package:hive/hive.dart';

class DailyPlanProvider extends ChangeNotifier {
  late final Box<DailyPlan> _box;
  List<DailyPlan> _plans = [];

  List<DailyPlan> get plans => _plans;

  DailyPlanProvider() {
    _box = Hive.box<DailyPlan>('plans');
    _loadPlans();
  }

  void _loadPlans() {
    _plans = _box.values.toList();
    notifyListeners();
  }

  /// Obtiene el plan para la fecha o crea uno nuevo con comidas predeterminadas
  DailyPlan getPlan(DateTime date) {
    // Buscar plan existente
    final index = _plans.indexWhere((p) => _isSameDate(p.date, date));
    if (index != -1) {
      return _plans[index];
    }
    // Crear plan nuevo con 3 comidas
    final newPlan = DailyPlan(
      date: date,
      meals: [
        Meal(type: 'Desayuno'),
        Meal(type: 'Almuerzo'),
        Meal(type: 'Cena'),
      ],
    );
    // Agregar a lista y notificar
    _plans.add(newPlan);
    notifyListeners();
    return newPlan;
  }

  void savePlan(DailyPlan plan) {
    final existingIndex = _plans.indexWhere(
      (p) => _isSameDate(p.date, plan.date),
    );
    if (existingIndex != -1) {
      _box.putAt(existingIndex, plan);
      _plans[existingIndex] = plan;
    } else {
      _box.add(plan);
      _plans.add(plan);
    }
    notifyListeners();
  }

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
