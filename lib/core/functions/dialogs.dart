import 'package:flutter/material.dart';
import 'package:taskati/core/utils/colors.dart';

showerrordialoge(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10),
      ),
      backgroundColor: AppColors.redcolor,
      content: Text(message),
    ),
  );
}
