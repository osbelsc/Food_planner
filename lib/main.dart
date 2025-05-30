// lib/main.dart
import 'package:flutter/material.dart';
import 'package:food_planner_app/features/alimento/providers/food_provider.dart';
import 'package:food_planner_app/features/calendar/providers/daily_plan_provider.dart';
import 'package:food_planner_app/features/recipes/providers/recipe_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/alimento/screens/food_list_screen.dart';
import 'features/home/screens/main_screen.dart';

import 'features/recipes/models/recipe.dart';
import 'features/alimento/models/food_item.dart';
import 'features/alimento/models/meal.dart';
import 'features/alimento/models/daily_plan.dart';
import 'core/prefs/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Registración de adaptadores de Hive
  Hive.registerAdapter(FoodItemAdapter());
  Hive.registerAdapter(MealAdapter());
  Hive.registerAdapter(DailyPlanAdapter());
  Hive.registerAdapter(RecipeAdapter());

  // Apertura de boxes
  await Hive.openBox<FoodItem>('foods');
  await Hive.openBox<DailyPlan>('plans');
  await Hive.openBox<Recipe>('recipes');

  // Preferencias del usuario
  final prefs = PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FoodProvider()),
        ChangeNotifierProvider(create: (_) => RecipeProvider()),
        ChangeNotifierProvider(create: (_) => DailyPlanProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Planner',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {'/': (_) => MainScreen(), '/foods': (_) => FoodListScreen()},
    );
  }
}
