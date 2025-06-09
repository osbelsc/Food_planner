import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_planner_app/core/widgets/buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:food_planner_app/core/constants/textstyle.dart';
import 'package:food_planner_app/features/recipes/providers/recipe_provider.dart';
import 'package:provider/provider.dart';
import '../../alimento/models/food_item.dart';

class AddRecipeScreen extends StatefulWidget {
  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _nameController = TextEditingController();
  final _foodNameController = TextEditingController();
  final _caloriesController = TextEditingController();

  File? _imageFile; // NUEVO: Imagen seleccionada

  final ImagePicker _picker = ImagePicker();

  void _onAddItem() {
    final name = _foodNameController.text.trim();
    final calories = int.tryParse(_caloriesController.text) ?? 0;

    if (name.isNotEmpty && calories > 0) {
      final item = FoodItem(name: name, calories: calories, description: '');
      context.read<RecipeProvider>().addTempItem(item);
      _foodNameController.clear();
      _caloriesController.clear();
    }
  }

  void _onSaveRecipe() {
    context.read<RecipeProvider>().updateTempName(_nameController.text);
    context.read<RecipeProvider>().updateTempImagePath(
      _imageFile?.path,
    ); // NUEVO: guarda imagen
    context.read<RecipeProvider>().saveTempRecipe();
    Navigator.pop(context);
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final tempItems = context.watch<RecipeProvider>().tempItems;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nueva Receta',
          style: TextStyleClass.poppinsBold(size: 18.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre de la receta'),
            ),
            SizedBox(height: 20),

            // NUEVO: Sección para imagen
            Text('Imagen de la receta', style: TextStyleClass.poppinsBold()),
            SizedBox(height: 10),
            GestureDetector(
              onTap: _pickImage,
              child:
                  _imageFile == null
                      ? Container(
                        height: 150,
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.add_a_photo,
                          size: 40,
                          color: Colors.grey,
                        ),
                      )
                      : Image.file(_imageFile!, height: 150, fit: BoxFit.cover),
            ),

            SizedBox(height: 20),
            Text('Agregar Ingrediente', style: TextStyleClass.poppinsBold()),
            TextField(
              controller: _foodNameController,
              decoration: InputDecoration(labelText: 'Nombre del alimento'),
            ),
            TextField(
              controller: _caloriesController,
              decoration: InputDecoration(labelText: 'Calorías'),
              keyboardType: TextInputType.number,
            ),
            CustomButton(text: 'Agregar alimento', onPressed: _onAddItem),

            Divider(height: 30),
            Text(
              'Ingredientes agregados:',
              style: TextStyleClass.poppinsSemiBold(),
            ),
            ...tempItems.map(
              (item) => ListTile(
                title: Text(item.name, style: TextStyleClass.poppinsSemiBold()),
                subtitle: Text(
                  '${item.calories} cal',
                  style: TextStyleClass.poppinsRegular(),
                ),
              ),
            ),
            SizedBox(height: 20),
            CustomButton(text: 'Guardar receta', onPressed: _onSaveRecipe),
          ],
        ),
      ),
    );
  }
}
