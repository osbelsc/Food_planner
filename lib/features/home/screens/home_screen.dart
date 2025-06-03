// lib/features/home/screens/home_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_planner_app/core/constants/textstyle.dart';
import 'package:food_planner_app/features/user/cubit/name_imput_cubit.dart';
import 'package:provider/provider.dart';

import 'package:food_planner_app/features/alimento/models/food_item.dart';
import 'package:food_planner_app/features/alimento/providers/food_provider.dart';

import '../../calendar/screens/calendar_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final username = context.watch<UserProvider>().username;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text('Food planer', style: TextStyleClass.poppinsBold()),
            Text(
              'listo para tus comidas?',
              style: TextStyleClass.poppinsRegular(),
            ),
          ],
        ),
      ),
      body: Center(),
    );
  }
}
