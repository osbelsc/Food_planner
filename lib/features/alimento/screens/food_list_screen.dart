import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_planner_app/core/constants/color.dart';
import 'package:food_planner_app/core/constants/textstyle.dart';
import 'package:food_planner_app/core/widgets/buttons.dart';
import 'package:food_planner_app/features/alimento/providers/food_provider.dart';
import 'package:food_planner_app/features/alimento/screens/add_food_screen.dart';
import 'package:food_planner_app/features/shared/widgets/food_card.dart';
import 'package:provider/provider.dart';

class FoodListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final foods = context.watch<FoodProvider>().foods;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Alimentos',
            style: TextStyleClass.poppinsBold(
              size: 25.0,
              color: ColorConst.appColor4,
            ),
          ),
          actions: [
            CustomButton(
              text: 'Agregar',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddFoodScreen()),
                );
              },
            ),
            // IconButton(
            //   icon: Icon(Icons.add),
            //   tooltip: 'Agregar alimento',
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (_) => AddFoodScreen()),
            //     );
            //   },
            // ),
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
                : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    final food = foods[index];
                    return FoodCard(
                      food: food,
                      onDelete: () {
                        context.read<FoodProvider>().removeFoodAt(index);
                      },
                    );
                  },
                ),
      ),
    );
  }
}
