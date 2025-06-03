import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_planner_app/core/constants/textstyle.dart';
import 'package:food_planner_app/features/alimento/providers/food_provider.dart';
import 'package:food_planner_app/features/alimento/screens/add_food_screen.dart';
import 'package:food_planner_app/features/shared/widgets/food_card.dart';
import 'package:provider/provider.dart';

class FoodListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final foods = context.watch<FoodProvider>().foods;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis Alimentos',
          style: TextStyleClass.poppinsBold(size: 18.0),
        ),
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
                  style: TextStyleClass.poppinsRegular(),
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
                    return FoodCard(
                      food: food,
                      onDelete:
                          () =>
                              context.read<FoodProvider>().removeFoodAt(index),
                    );
                  },
                ),
              ),
    );
  }
}
