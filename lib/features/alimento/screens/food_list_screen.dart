import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_planner_app/features/alimento/providers/food_provider.dart';
import 'package:food_planner_app/features/alimento/screens/add_food_screen.dart';
import 'package:provider/provider.dart';

class FoodListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final foods = context.watch<FoodProvider>().foods;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Alimentos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Agregar alimento',
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddFoodScreen()),
                ),
          ),
        ],
      ),
      body:
          foods.isEmpty
              ? Center(
                child: Text(
                  'No hay alimentos agregados',
                  style: TextStyle(fontSize: 16),
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: foods.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.7 / 2,
                  ),
                  itemBuilder: (context, index) {
                    final food = foods[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (food.imagePath != null)
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(8),
                              ),
                              child: Image.file(
                                File(food.imagePath!),
                                height: 100,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            )
                          else
                            Container(
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(8),
                                ),
                              ),
                              child: Icon(
                                Icons.image,
                                size: 40,
                                color: Colors.grey[600],
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  food.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 2),
                                Text(
                                  '${food.calories} cal',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed:
                                        () => context
                                            .read<FoodProvider>()
                                            .removeFoodAt(index),
                                    tooltip: 'Eliminar',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
