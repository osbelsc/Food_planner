import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_planner_app/core/constants/color.dart';
import 'package:food_planner_app/core/constants/textstyle.dart';
import 'package:food_planner_app/core/widgets/buttons.dart';
import 'package:food_planner_app/features/alimento/models/food_item.dart';

class FoodCard extends StatelessWidget {
  final FoodItem food;
  final VoidCallback onDelete;

  const FoodCard({Key? key, required this.food, required this.onDelete})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      color: ColorConst.appColor1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Row(
          children: [
            // Imagen
            if (food.imagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(16),
                ),
                child: Image.file(
                  File(food.imagePath!),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: ColorConst.appColor4,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(16),
                  ),
                ),
                child: Icon(
                  Icons.fastfood,
                  size: 40,
                  color: ColorConst.appColor1,
                ),
              ),

            // Información
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      style: TextStyleClass.poppinsBold(
                        size: 18.0,
                        color: ColorConst.appColor4,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${food.calories} calorías',
                      style: TextStyleClass.poppinsRegular(
                        color: ColorConst.appColor4,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Botón de eliminar
            DeleteButton(onTap: onDelete),
            // IconButton(
            //   icon: Icon(Icons.delete, color: Colors.red),
            //   tooltip: 'Eliminar alimento',
            //   onPressed: onDelete,
            // ),
          ],
        ),
      ),
    );
  }
}
