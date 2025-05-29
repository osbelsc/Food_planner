// lib/features/alimento/screens/add_food_item_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../cubit/food_cubit.dart';
import '../models/food_item.dart';

class AddFoodScreen extends StatefulWidget {
  @override
  _AddFoodScreenState createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _image;

  Future _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final calories = int.parse(_caloriesController.text.trim());
      final description = _descriptionController.text.trim();
      final imagePath = _image?.path;
      context.read<FoodCubit>().createFood(
        name: name,
        calories: calories,
        description: description,
        imagePath: imagePath,
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Alimento')),
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
                  if (n == null || n <= 0) return 'Ingrese un número válido';
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
              Text(
                'Imagen (opcional)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              if (_image != null)
                Image.file(_image!, height: 120, width: 120, fit: BoxFit.cover),
              TextButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.photo),
                label: Text('Seleccionar imagen'),
              ),
              SizedBox(height: 24),
              ElevatedButton(onPressed: _save, child: Text('Guardar Alimento')),
            ],
          ),
        ),
      ),
    );
  }
}
