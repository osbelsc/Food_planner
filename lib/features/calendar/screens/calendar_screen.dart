import 'package:flutter/material.dart';
import 'package:food_planner_app/core/constants/textstyle.dart';
import 'package:food_planner_app/features/alimento/models/daily_plan.dart';
import 'package:food_planner_app/features/alimento/models/meal.dart';
import 'package:food_planner_app/features/alimento/providers/food_provider.dart';
import 'package:food_planner_app/features/calendar/widgets/meal_card.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../providers/daily_plan_provider.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  DailyPlan? _plan;

  @override
  void initState() {
    super.initState();
    // Espera hasta que se construya para acceder al provider sin error
    Future.microtask(() {
      final planProv = context.read<DailyPlanProvider>();
      final plan = planProv.getPlan(_selectedDay);
      setState(() => _plan = plan);
    });
  }

  void _onDaySelected(DateTime selected, DateTime focused) {
    setState(() {
      _selectedDay = selected;
      _focusedDay = focused;
      _plan = context.read<DailyPlanProvider>().getPlan(selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    final foodProv = context.watch<FoodProvider>();

    if (_plan == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
      // return Scaffold(
      //   appBar: AppBar(title: Text('Planificador de Comidas')),
      //   body: Center(child: CircularProgressIndicator()),
      // );
    }

    // Extraer comidas por tipo
    Meal findMeal(String type) {
      return _plan!.meals.firstWhere(
        (m) => m.type == type,
        orElse: () {
          final m = Meal(type: type);
          _plan!.meals.add(m);
          return m;
        },
      );
    }

    final desayuno = findMeal('Desayuno');
    final almuerzo = findMeal('Almuerzo');
    final cena = findMeal('Cena');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Planificador de Comidas',
          style: TextStyleClass.poppinsBold(size: 18.0),
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
            onDaySelected: _onDaySelected,
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 8),
              children: [
                MealCard(
                  mealType: 'Desayuno',
                  items: desayuno.items,
                  allFoods: foodProv.foods,
                  onAddFoodToMeal: (food) {
                    desayuno.items.add(food);
                    context.read<DailyPlanProvider>().savePlan(_plan!);
                  },
                ),
                MealCard(
                  mealType: 'Almuerzo',
                  items: almuerzo.items,
                  allFoods: foodProv.foods,
                  onAddFoodToMeal: (food) {
                    almuerzo.items.add(food);
                    context.read<DailyPlanProvider>().savePlan(_plan!);
                  },
                ),
                MealCard(
                  mealType: 'Cena',
                  items: cena.items,
                  allFoods: foodProv.foods,
                  onAddFoodToMeal: (food) {
                    cena.items.add(food);
                    context.read<DailyPlanProvider>().savePlan(_plan!);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
