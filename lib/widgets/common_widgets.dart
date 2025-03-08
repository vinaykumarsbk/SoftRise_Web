import 'package:flutter/material.dart';
import 'package:soft_rise/globals/app_buttons.dart';
import 'package:soft_rise/globals/app_colors.dart';
import 'package:soft_rise/globals/app_text_styles.dart';
import 'package:soft_rise/globals/utility.dart';

// Reusable Widget for Heading Text (e.g. "About Us", "Our Services")
Widget buildHeadingText(String text, {double fontSize = 30.0, Color? color}) {
  return RichText(
    text: TextSpan(
      text: text,
      style: AppTextStyles.headingStyles(fontSize: fontSize, color: color ?? AppColors.white),
    ),
  );
}

// Reusable TextField widget for forms
Widget buildTextField({required String hintText, bool isMessage = false}) {
  return Material(
    borderRadius: BorderRadius.circular(10),
    color: Colors.transparent,
    elevation: 8,
    child: TextField(
      maxLines: isMessage ? 15 : 1,
      cursorColor: AppColors.white,
      style: AppTextStyles.normalStyle(),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.comfortaaStyle(),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        filled: true,
        fillColor: AppColors.bgColor2,
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
    ),
  );
}

// Reusable Service Card (used in multiple pages)
Widget buildServiceCard({
  required String title,
  required String description,
  required String asset,
  required bool hover,
  required Function(bool) onHover,
}) {
  final onHoverActive = Matrix4.identity()..translate(0, -10, 0);
  final onHoverRemove = Matrix4.identity()..translate(0, 0, 0);

  return InkWell(
    onTap: () {},
    onHover: onHover,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: hover ? 365.0 : 355.0,
      height: hover ? 390 : 380,
      alignment: Alignment.center,
      transform: hover ? onHoverActive : onHoverRemove,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.bgColor2,
        borderRadius: BorderRadius.circular(30),
        border: hover ? Border.all(color: AppColors.themeColor, width: 3) : null,
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            spreadRadius: 4.0,
            blurRadius: 4.5,
            offset: Offset(3.0, 4.5),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            asset,
            width: 50,
            height: 50,
            color: AppColors.themeColor,
          ),
          Utility.sizedBox(height: 30.0),
          Text(
            title,
            style: AppTextStyles.montserratStyle(color: Colors.white, fontSize: 22.0),
          ),
          Utility.sizedBox(height: 12.0),
          Text(
            description,
            style: AppTextStyles.normalStyle(fontSize: 14.0),
            textAlign: TextAlign.center,
          ),
          Utility.sizedBox(height: 20.0),
          AppButtons.buildMaterialButton(buttonName: 'Read More', onTap: () {}),
        ],
      ),
    ),
  );
}
