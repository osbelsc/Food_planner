import "package:flutter/material.dart";
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
      title: Text(
        food.name,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      subtitle: Text('${food.calories} cal'),
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
