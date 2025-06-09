import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_planner_app/core/constants/textstyle.dart';
import 'package:food_planner_app/features/recipes/providers/recipe_provider.dart';
import 'package:food_planner_app/features/recipes/screens/add_recipe_Screen.dart';
import 'package:provider/provider.dart';

class RecipeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recipes = context.watch<RecipeProvider>().recipes;

    return Scaffold(
      appBar: AppBar(
        title: Text('Recetas', style: TextStyleClass.poppinsBold(size: 18.0)),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Agregar receta',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddRecipeScreen()),
              );
            },
          ),
        ],
      ),
      body:
          recipes.isEmpty
              ? Center(
                child: Text(
                  'No hay recetas agregadas',
                  style: TextStyleClass.poppinsRegular(size: 16.0),
                ),
              )
              : ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  final recipe = recipes[index];

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Imagen (si existe)
                        if (recipe.imagePath != null)
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: Image.file(
                              File(recipe.imagePath!),
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipe.name,
                                style: TextStyleClass.poppinsBold(size: 18.0),
                              ),
                              SizedBox(height: 8),
                              ...recipe.items.map(
                                (item) => Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2),
                                  child: Text(
                                    '• ${item.name} (${item.calories} cal)',
                                    style: TextStyleClass.poppinsRegular(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          tooltip: 'Eliminar receta',
                          onPressed: () {
                            context.read<RecipeProvider>().removeRecipeAt(
                              index,
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}
