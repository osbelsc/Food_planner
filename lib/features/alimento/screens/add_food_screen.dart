import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/food_cubit.dart';
import '../cubit/daily_plan_cubit.dart';
import '../models/daily_plan.dart';
import '../models/meal.dart';
import '../models/food_item.dart';

class AddFoodScreen extends StatefulWidget {
  final DateTime date;
  AddFoodScreen({required this.date});

  @override
  _AddFoodScreenState createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  late DailyPlan _plan;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<DailyPlanCubit>();
    _plan = cubit.getPlan(widget.date)!;
  }

  @override
  Widget build(BuildContext context) {
    final foods = context.watch<FoodCubit>().state;
    return Scaffold(
      appBar: AppBar(
        title: Text('Comidas ${widget.date.toLocal()}'.split(' ')[0]),
      ),
      body: ListView(
        children:
            ['Desayuno', 'Almuerzo', 'Cena'].map((type) {
              final meal = _plan.meals.firstWhere(
                (m) => m.type == type,
                orElse: () {
                  final m = Meal(type: type);
                  _plan.meals.add(m);
                  return m;
                },
              );
              return ExpansionTile(
                title: Text(type),
                children: [
                  ...meal.items.map(
                    (item) => ListTile(
                      title: Text(item.name),
                      subtitle: Text('${item.calories} cal'),
                    ),
                  ),
                  DropdownButton<FoodItem>(
                    hint: Text('Agregar alimento'),
                    items:
                        foods
                            .map(
                              (f) => DropdownMenuItem<FoodItem>(
                                value: f,
                                child: Text(f.name),
                              ),
                            )
                            .toList(),
                    onChanged: (f) {
                      if (f == null) return;
                      setState(() {
                        meal.items.add(f);
                      });
                      context.read<DailyPlanCubit>().savePlan(_plan);
                    },
                  ),
                ],
              );
            }).toList(),
      ),
    );
  }
}
