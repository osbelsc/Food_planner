import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_planner_app/features/alimento/models/food_item.dart';
import 'package:food_planner_app/features/recipes/cubit/recipe_cubit.dart';

class AddRecipeScreen extends StatefulWidget {
  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _nameController = TextEditingController();
  final _foodNameController = TextEditingController();
  final _caloriesController = TextEditingController();

  void _onAddItem() {
    final name = _foodNameController.text.trim();
    final calories = int.tryParse(_caloriesController.text) ?? 0;

    if (name.isNotEmpty && calories > 0) {
      final item = FoodItem(name: name, calories: calories, description: '');
      context.read<RecipeCubit>().addTempItem(item);
      _foodNameController.clear();
      _caloriesController.clear();
      setState(() {}); // Solo para actualizar la lista temporal
    }
  }

  void _onSaveRecipe() {
    context.read<RecipeCubit>().updateTempName(_nameController.text);
    context.read<RecipeCubit>().saveTempRecipe();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final tempItems = context.read<RecipeCubit>().tempItems;

    return Scaffold(
      appBar: AppBar(title: Text('Nueva Receta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre de la receta'),
            ),
            SizedBox(height: 20),
            Text(
              'Agregar Ingrediente',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _foodNameController,
              decoration: InputDecoration(labelText: 'Nombre del alimento'),
            ),
            TextField(
              controller: _caloriesController,
              decoration: InputDecoration(labelText: 'Calorías'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _onAddItem,
              child: Text('Agregar alimento'),
            ),
            Divider(height: 30),
            Text(
              'Ingredientes agregados:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            ...tempItems.map(
              (item) => ListTile(
                title: Text(item.name),
                subtitle: Text('${item.calories} cal'),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onSaveRecipe,
              child: Text('Guardar receta'),
            ),
          ],
        ),
      ),
    );
  }
}
