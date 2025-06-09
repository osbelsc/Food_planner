import 'package:food_planner_app/core/constants/color.dart';

import 'package:flutter/material.dart';

class TextStyleClass {
  ///Poppins Regular
  static poppinsRegular({var color, var size}) {
    return TextStyle(
      color: color ?? ColorConst.black,
      fontSize: size ?? 14.0,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w400,
    );
  }

  ///Poppins semibold
  static poppinsSemiBold({var color, var size}) {
    return TextStyle(
      color: color ?? ColorConst.black,
      fontSize: size ?? 14.0,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w600,
    );
  }

  ///Poppins Bold
  static poppinsBold({var color, var size}) {
    return TextStyle(
      color: color ?? ColorConst.black,
      fontSize: size ?? 14.0,
      fontFamily: "Poppins",
      fontWeight: FontWeight.w700,
    );
  }
}
