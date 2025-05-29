// lib/screens/food_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_planner_app/features/alimento/cubit/food_cubit.dart';
import 'package:food_planner_app/features/alimento/models/food_item.dart';

class FoodListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mis Alimentos')),
      body: BlocBuilder<FoodCubit, List<FoodItem>>(
        builder: (context, foods) {
          if (foods.isEmpty) {
            return Center(
              child: Text(
                'No hay alimentos agregados',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: GridView.builder(
              itemCount: foods.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Dos columnas
                mainAxisSpacing: 8, // Espacio vertical entre cards
                crossAxisSpacing: 8, // Espacio horizontal entre cards
                childAspectRatio: 3 / 2, // Relación ancho/alto de cada card
              ),
              itemBuilder: (context, index) {
                final food = foods[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${food.calories} cal',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context.read<FoodCubit>().removeFood(index);
                          },
                          tooltip: 'Eliminar',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
