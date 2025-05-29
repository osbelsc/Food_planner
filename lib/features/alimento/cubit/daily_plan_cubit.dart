import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../models/daily_plan.dart';

class DailyPlanCubit extends Cubit<List<DailyPlan>> {
  late final Box<DailyPlan> _box;

  DailyPlanCubit() : super([]) {
    _box = Hive.box<DailyPlan>('plans');
    emit(_box.values.toList());
  }

  DailyPlan getPlan(DateTime date) {
    return _box.values.firstWhere(
      (p) => _isSameDate(p.date, date),
      orElse: () => DailyPlan(date: date),
    );
  }

  void savePlan(DailyPlan plan) {
    final existingKey = _box.keys.cast<int?>().firstWhere((k) {
      final val = _box.get(k);
      return val != null && _isSameDate(val.date, plan.date);
    }, orElse: () => null);

    if (existingKey != null) {
      _box.put(existingKey, plan);
    } else {
      _box.add(plan);
    }

    emit(_box.values.toList());
  }

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
