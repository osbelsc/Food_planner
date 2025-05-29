import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_planner_app/features/alimento/cubit/daily_plan_cubit.dart';
import 'package:food_planner_app/features/alimento/cubit/food_cubit.dart';
import 'package:food_planner_app/features/alimento/models/meal.dart';
import 'package:food_planner_app/features/alimento/widgets/meal_card.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final allFoods = context.watch<FoodCubit>().state;
    // Obtén el plan diario actual (o uno nuevo si no existe)
    final plan =
        context.read<DailyPlanCubit>().getPlan(_selectedDay ?? DateTime.now())!;
    // Extrae o crea las meals
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
            onDaySelected: (sel, foc) {
              setState(() {
                _selectedDay = sel;
                _focusedDay = foc;
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
                    context.read<DailyPlanCubit>().savePlan(plan);
                    setState(() {}); // refresca la UI
                  },
                ),
                MealCard(
                  mealType: 'Almuerzo',
                  items: almuerzo.items,
                  allFoods: allFoods,
                  onAddFoodToMeal: (food) {
                    almuerzo.items.add(food);
                    context.read<DailyPlanCubit>().savePlan(plan);
                    setState(() {});
                  },
                ),
                MealCard(
                  mealType: 'Cena',
                  items: cena.items,
                  allFoods: allFoods,
                  onAddFoodToMeal: (food) {
                    cena.items.add(food);
                    context.read<DailyPlanCubit>().savePlan(plan);
                    setState(() {});
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
