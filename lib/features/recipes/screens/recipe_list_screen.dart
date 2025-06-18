import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_planner_app/core/constants/color.dart';
import 'package:food_planner_app/core/constants/textstyle.dart';
import 'package:food_planner_app/core/widgets/buttons.dart';
import 'package:food_planner_app/features/recipes/providers/recipe_provider.dart';
import 'package:food_planner_app/features/recipes/screens/add_recipe_Screen.dart';
import 'package:food_planner_app/features/shared/widgets/recipe_card.dart';
import 'package:provider/provider.dart';

class RecipeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final recipes = context.watch<RecipeProvider>().recipes;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Recetas',
            style: TextStyleClass.poppinsBold(
              size: 25.0,
              color: ColorConst.appColor4,
            ),
          ),
          actions: [
            CustomButton(
              text: 'Agregar',
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

                    return RecipeCard(
                      recipe: recipe,
                      onDelete: () {
                        context.read<RecipeProvider>().removeRecipeAt(index);
                      },
                    );
                  },
                ),
      ),
    );
  }
}
