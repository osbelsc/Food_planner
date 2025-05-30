import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_planner_app/features/alimento/providers/food_provider.dart';
import 'package:food_planner_app/features/calendar/providers/daily_plan_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../alimento/models/meal.dart';
import '../../alimento/widgets/meal_card.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final allFoods = context.watch<FoodProvider>().foods;
    final planProvider = context.watch<DailyPlanProvider>();
    final plan = planProvider.getPlan(_selectedDay);

    final desayuno = plan.meals.firstWhere(
      (m) => m.type == 'Desayuno',
      orElse: () => Meal(type: 'Desayuno'),
    );
    final almuerzo = plan.meals.firstWhere(
      (m) => m.type == 'Almuerzo',
      orElse: () => Meal(type: 'Almuerzo'),
    );
    final cena = plan.meals.firstWhere(
      (m) => m.type == 'Cena',
      orElse: () => Meal(type: 'Cena'),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Calendario de comidas')),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020),
            lastDay: DateTime.utc(2030),
            focusedDay: _focusedDay,
            selectedDayPredicate: (d) => isSameDay(d, _selectedDay),
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              });
            },
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(bottom: 16),
              children: [
                MealCard(
                  mealType: 'Desayuno',
                  items: desayuno.items,
                  allFoods: allFoods,
                  onAddFoodToMeal: (food) {
                    desayuno.items.add(food);
                    planProvider.savePlan(plan);
                  },
                ),
                MealCard(
                  mealType: 'Almuerzo',
                  items: almuerzo.items,
                  allFoods: allFoods,
                  onAddFoodToMeal: (food) {
                    almuerzo.items.add(food);
                    planProvider.savePlan(plan);
                  },
                ),
                MealCard(
                  mealType: 'Cena',
                  items: cena.items,
                  allFoods: allFoods,
                  onAddFoodToMeal: (food) {
                    cena.items.add(food);
                    planProvider.savePlan(plan);
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
