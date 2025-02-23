import 'package:flutter/material.dart';

class UiHelper {
  // Custom Image Widget
  static Widget customImage({
    required String img,
    BoxFit fit = BoxFit.contain,
    double? width,
    double? height,
  }) {
    return Image.asset(
      "assets/images/$img",
      fit: fit,
      width: width,
      height: height,
    );
  }

  // Custom Text Widget
  static Widget customText({
    required String text,
    required Color color,
    required FontWeight fontWeight,
    required double fontSize,
    String? fontFamily,
    TextOverflow? overflow,
    int? maxLines,
    TextAlign? textAlign,
  }) {
    return Text(
      text,
      maxLines: maxLines ?? 1,
      textAlign: textAlign ?? TextAlign.start,
      style: TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: fontFamily ?? "regular",
        overflow: overflow ?? TextOverflow.ellipsis,
      ),
    );
  }

  // Custom Search Field
  static Widget customSearchField({
    required TextEditingController controller,
    String hintText = "Search...",
    Color borderColor = const Color(0XFFC5C5C5),
    IconData prefixIcon = Icons.search,
    IconData? suffixIcon,
  }) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: borderColor),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(prefixIcon),
          suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
          border: InputBorder.none,
        ),
      ),
    );
  }

  // Custom Button
  static Widget customButton({
    required VoidCallback onTapped,
    required String text,
    double height = 40,
    double width = 100,
    Color textColor = Colors.white,
    Color backgroundColor = const Color(0XFF27AF34),
    double borderRadius = 8.0,
    double fontSize = 14.0,
  }) {
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: Colors.green),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }

  // Custom Card Widget
  static Widget customCard({
    required Widget child,
    double elevation = 2.0,
    Color color = Colors.white,
    double borderRadius = 12.0,
    EdgeInsetsGeometry padding = const EdgeInsets.all(12.0),
  }) {
    return Card(
      elevation: elevation,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }

  static Widget customTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}