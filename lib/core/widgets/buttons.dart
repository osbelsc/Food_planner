import 'package:flutter/material.dart';
import 'package:food_planner_app/core/constants/color.dart';
import 'package:food_planner_app/core/constants/textstyle.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({Key? key, required this.text, required this.onPressed})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConst.appColor4,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        text,
        style: TextStyleClass.poppinsBold(color: ColorConst.white),
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  final VoidCallback onTap;
  final double size;

  const DeleteButton({
    Key? key,
    required this.onTap,
    this.size = 30.0, // Puedes ajustar el tamaño
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
        child: Center(
          child: Icon(Icons.close, color: Colors.white, size: size * 0.6),
        ),
      ),
    );
  }
}
