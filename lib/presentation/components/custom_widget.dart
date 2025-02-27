import 'dart:io';

import 'package:flutter/material.dart';

class UiHelper {

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
      child: Padding(padding: padding, child: child),
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  static Widget customImagePicker({
    required Function() onTap,
    required File? imageFile,
    double height = 200,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child:
            imageFile != null
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(imageFile, fit: BoxFit.cover),
                )
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 50,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 8),
                    UiHelper.customText(
                      text: "Add Project Image",
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ],
                ),
      ),
    );
  }

  static Widget customMultiLineHelper({
    required TextEditingController controller,
    required String hintText,
    IconData icon = Icons.description,
    int maxLines = 5,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 8,
          ),
        ),
      ),
    );
  }

  static Widget customTagInput({
    required TextEditingController controller,
    required VoidCallback onAddPressed,
    String hintText = "Add a tag",
  }) {
    return Row(
      children: [
        Expanded(
          child: UiHelper.customTextField(
            controller: controller,
            hintText: hintText,
            icon: Icons.tag,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: onAddPressed,
          ),
        ),
      ],
    );
  }
}
