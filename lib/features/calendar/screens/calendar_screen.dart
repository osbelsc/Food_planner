import 'package:flutter/material.dart';
import 'package:food_planner_app/features/alimento/models/meal.dart';
import 'package:food_planner_app/features/alimento/providers/food_provider.dart';
import 'package:food_planner_app/features/alimento/widgets/meal_card.dart';
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

  @override
  Widget build(BuildContext context) {
    final foodProv = context.watch<FoodProvider>();
    final planProv = context.watch<DailyPlanProvider>();

    // Obtener o crear plan para la fecha seleccionada
    final plan = planProv.getPlan(_selectedDay);

    // Extraer comidas por tipo
    Meal findMeal(String type) {
      return plan.meals.firstWhere(
        (m) => m.type == type,
        orElse: () {
          final m = Meal(type: type);
          plan.meals.add(m);
          return m;
        },
      );
    }

    final desayuno = findMeal('Desayuno');
    final almuerzo = findMeal('Almuerzo');
    final cena = findMeal('Cena');

    return Scaffold(
      appBar: AppBar(title: Text('Planificador de Comidas')),
      body: Column(
        children: [
          // Calendario
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              });
            },
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
                    planProv.savePlan(plan);
                  },
                ),
                MealCard(
                  mealType: 'Almuerzo',
                  items: almuerzo.items,
                  allFoods: foodProv.foods,
                  onAddFoodToMeal: (food) {
                    almuerzo.items.add(food);
                    planProv.savePlan(plan);
                  },
                ),
                MealCard(
                  mealType: 'Cena',
                  items: cena.items,
                  allFoods: foodProv.foods,
                  onAddFoodToMeal: (food) {
                    cena.items.add(food);
                    planProv.savePlan(plan);
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
