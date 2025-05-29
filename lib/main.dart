// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_planner_app/features/alimento/screens/food_list_screen.dart';
import 'package:food_planner_app/features/home/screens/main_screen.dart';
import 'package:food_planner_app/features/recipes/cubit/recipe_cubit.dart';
import 'package:food_planner_app/features/recipes/models/recipe.dart';

import 'package:food_planner_app/features/user/cubit/name_imput_cubit.dart';
import 'package:food_planner_app/features/user/screens/name_imput_screen.dart';
import 'package:food_planner_app/core/prefs/shared_preferences.dart';
import 'features/alimento/cubit/food_cubit.dart';
import 'features/alimento/cubit/daily_plan_cubit.dart';
import 'features/alimento/models/food_item.dart';
import 'features/alimento/models/meal.dart';
import 'features/alimento/models/daily_plan.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  //await Hive.deleteFromDisk();

  Hive.registerAdapter(FoodItemAdapter());
  Hive.registerAdapter(MealAdapter());
  Hive.registerAdapter(DailyPlanAdapter());

  await Hive.openBox<FoodItem>('foods');
  await Hive.openBox<DailyPlan>('plans');
  await Hive.openBox<Recipe>('recipes');

  final prefs = PreferenciasUsuario();
  await prefs.initPrefs();
  final username = prefs.usuario.isNotEmpty ? prefs.usuario : null;

  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  final String? username;
  const MyApp({required this.username});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FoodCubit()),
        BlocProvider(create: (_) => DailyPlanCubit()),
        BlocProvider(create: (_) => UserCubit()),
        BlocProvider(create: (_) => RecipeCubit()),
      ],
      child: MaterialApp(
        title: 'Food Planner',
        theme: ThemeData(primarySwatch: Colors.green),
        initialRoute: '/',
        routes: {
          // Pantalla inicial que valida si ya hay usuario
          '/': (context) => MainScreen(),
          '/foods': (_) => FoodListScreen(),
          '/name_input': (context) => NameInputScreen(),
          // Agrega más rutas si tienes
        },
      ),
    );
  }
}
