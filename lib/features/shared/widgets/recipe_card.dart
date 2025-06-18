import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_planner_app/core/constants/color.dart';
import 'package:food_planner_app/core/constants/textstyle.dart';
import 'package:food_planner_app/core/widgets/buttons.dart';
import 'package:food_planner_app/features/recipes/models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onDelete;

  const RecipeCard({Key? key, required this.recipe, required this.onDelete})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      color: ColorConst.appColor1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Sección de la imagen
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              color: ColorConst.appColor4,
            ),
            child:
                recipe.imagePath != null
                    ? ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.file(
                        File(recipe.imagePath!),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 150,
                      ),
                    )
                    : Center(
                      child: Icon(
                        Icons.fastfood,
                        size: 50,
                        color: ColorConst.appColor1,
                      ),
                    ),
          ),
          // Sección del contenido
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    recipe.name,
                    style: TextStyleClass.poppinsBold(
                      size: 18.0,
                      color: ColorConst.appColor4,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                DeleteButton(onTap: onDelete),
                // IconButton(
                //   icon: Icon(Icons.delete, color: Colors.red),
                //   onPressed: onDelete,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
