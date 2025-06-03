import 'package:flutter/material.dart';
import 'package:food_planner_app/core/constants/textstyle.dart';
import 'package:food_planner_app/features/alimento/models/food_item.dart';

class MealCard extends StatelessWidget {
  final String mealType; // "Desayuno", "Almuerzo", "Cena"
  final List<FoodItem> items;
  final List<FoodItem> allFoods;
  final void Function(FoodItem) onAddFoodToMeal;

  const MealCard({
    required this.mealType,
    required this.items,
    required this.allFoods,
    required this.onAddFoodToMeal,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(mealType, style: TextStyleClass.poppinsBold(size: 17.0)),
            Divider(color: Colors.grey[300]),
            // Lista de alimentos en esta meal
            ...items.map(
              (f) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                title: Text(f.name, style: TextStyleClass.poppinsRegular()),
                subtitle: Text(
                  '${f.calories} cal',
                  style: TextStyleClass.poppinsRegular(),
                ),
              ),
            ),
            // Dropdown para agregar nuevo FoodItem
            DropdownButton<FoodItem>(
              hint: Text(
                'Agregar alimento',
                style: TextStyleClass.poppinsSemiBold(),
              ),
              items:
                  allFoods.map((f) {
                    return DropdownMenuItem<FoodItem>(
                      value: f,
                      child: Text(
                        f.name,
                        style: TextStyleClass.poppinsRegular(),
                      ),
                    );
                  }).toList(),
              onChanged: (selectedFood) {
                if (selectedFood != null) {
                  onAddFoodToMeal(selectedFood);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
