import "package:flutter/material.dart";
import "package:food_planner_app/core/constants/textstyle.dart";
import "package:food_planner_app/features/alimento/models/food_item.dart";

class FoodTile extends StatelessWidget {
  final FoodItem food;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const FoodTile({
    required this.food,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(food.name, style: TextStyleClass.poppinsRegular(size: 16.0)),
      subtitle: Text(
        '${food.calories} cal',
        style: TextStyleClass.poppinsRegular(),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(icon: Icon(Icons.edit, size: 20), onPressed: onEdit),
          IconButton(
            icon: Icon(Icons.delete, size: 20, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
