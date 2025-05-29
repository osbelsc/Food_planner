import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_planner_app/features/alimento/cubit/food_cubit.dart';
import 'package:food_planner_app/features/user/cubit/name_imput_cubit.dart';

import 'package:food_planner_app/features/alimento/models/food_item.dart';
import 'package:food_planner_app/features/user/screens/name_imput_screen.dart';
// Corrige el nombre si es necesario
import '../../calendar/screens/calendar_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, String>(
      builder: (context, username) {
        return Scaffold(
          appBar: AppBar(
            title: GestureDetector(
              onTap: () async {
                // Navegar a la pantalla para cambiar nombre
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NameInputScreen()),
                );
                // Después de volver, recarga el username en el cubit
                context.read<UserCubit>().loadUsername();
              },
              child: Text('Hola, ${username.isEmpty ? 'Usuario' : username}'),
            ),
          ),
          body: Center(
            child: ElevatedButton(
              child: Text('Ver calendario'),
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CalendarScreen()),
                  ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showAddFoodDialog(context),
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }

  void _showAddFoodDialog(BuildContext context) {
    final nameController = TextEditingController();
    final caloriesController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Agregar alimento'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: caloriesController,
                  decoration: InputDecoration(labelText: 'Calorías'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  final name = nameController.text;
                  final description = descriptionController.text;
                  final calories = int.tryParse(caloriesController.text) ?? 0;
                  if (name.isNotEmpty &&
                      calories > 0 &&
                      description.isNotEmpty) {
                    final food = FoodItem(
                      name: name,
                      calories: calories,
                      description: description,
                    );
                    context.read<FoodCubit>().addFood(food);
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Agregar'),
              ),
            ],
          ),
    );
  }
}
