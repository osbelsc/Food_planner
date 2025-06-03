// lib/features/alimento/screens/add_food_screen.dart
import 'package:flutter/material.dart';
import 'package:food_planner_app/core/constants/textstyle.dart';
import 'package:provider/provider.dart';
import '../providers/food_provider.dart';

class AddFoodScreen extends StatefulWidget {
  @override
  _AddFoodScreenState createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _save(FoodProvider provider) async {
    if (_formKey.currentState!.validate()) {
      await provider.createFood(
        name: _nameController.text.trim(),
        calories: int.parse(_caloriesController.text.trim()),
        description: _descriptionController.text.trim(),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FoodProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agregar Alimento',
          style: TextStyleClass.poppinsBold(size: 18.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _caloriesController,
                decoration: InputDecoration(labelText: 'Calorías'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Requerido';
                  final n = int.tryParse(v);
                  if (n == null || n <= 0) return 'Número inválido';
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
              ),
              SizedBox(height: 12),
              Text('Imagen (opcional)', style: TextStyleClass.poppinsBold()),
              SizedBox(height: 8),
              if (provider.selectedImage != null)
                Image.file(
                  provider.selectedImage!,
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              TextButton.icon(
                onPressed: provider.pickImage,
                icon: Icon(Icons.photo),
                label: Text(
                  'Seleccionar imagen',
                  style: TextStyleClass.poppinsRegular(),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _save(provider),
                child: Text(
                  'Guardar Alimento',
                  style: TextStyleClass.poppinsRegular(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
