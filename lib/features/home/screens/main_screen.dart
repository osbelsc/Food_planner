import 'package:flutter/material.dart';
import 'package:food_planner_app/features/calendar/screens/calendar_screen.dart';
import 'package:food_planner_app/features/alimento/screens/food_list_screen.dart';
import 'package:food_planner_app/features/home/screens/home_screen.dart';
import 'package:food_planner_app/features/recipes/screens/recipe_list_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Aquí defines las vistas para cada tab
  final List<Widget> _screens = [
    HomeScreen(),
    FoodListScreen(),
    CalendarScreen(),
    RecipeListScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Alimentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_rounded),
            label: 'Recetas',
          ),
        ],
      ),
    );
  }
}
