import 'package:flutter/material.dart';
import 'package:food_planner_app/core/constants/color.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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

  final List<Widget> _screens = [
    HomeScreen(),
    FoodListScreen(),
    CalendarScreen(),
    RecipeListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: ColorConst.appColor1,
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.1)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: GNav(
            gap: 5,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            backgroundColor: ColorConst.appColor1,
            tabBackgroundColor: ColorConst.appColor4,
            color: Colors.grey[500],
            activeColor: ColorConst.appColor1,
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.fastfood, text: 'Alimentos'),
              GButton(icon: Icons.calendar_today, text: 'Calendario'),
              GButton(icon: Icons.menu_book, text: 'Recetas'),
            ],
          ),
        ),
      ),
    );
  }
}
