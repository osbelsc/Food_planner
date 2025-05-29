import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_planner_app/features/recipes/cubit/recipe_cubit.dart';
import 'package:food_planner_app/features/recipes/screens/add_recipe_Screen.dart';

class RecipeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recetas'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Agregar receta',
            onPressed: () {
              // Navegar a pantalla de creación de receta
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddRecipeScreen()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<RecipeCubit, List>(
        builder: (context, recipes) {
          if (recipes.isEmpty) {
            return Center(
              child: Text(
                'No hay recetas agregadas',
                style: TextStyle(fontSize: 16),
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      // Listado de FoodItem
                      ...recipe.items.map(
                        (item) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            '• ${item.name} (${item.calories} cal)',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Nota: Crear AddRecipeScreen que permita ingresar nombre y seleccionar FoodItems para la lista.
