import 'package:flutter/material.dart';
import 'package:soft_rise/globals/app_buttons.dart';
import 'package:soft_rise/globals/app_colors.dart';
import 'package:soft_rise/globals/app_text_styles.dart';
import 'package:soft_rise/globals/utility.dart';
import 'package:soft_rise/helper%20class/helper_class.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return HelperClass(
      mobile: buildForm(),
      tablet: buildForm(),
      desktop: buildForm(),
      paddingWidth: size.width * 0.2,
      bgColor: AppColors.appBarColor,
      bgColor1: AppColors.appBarColor1,
      bgColor2: AppColors.appBarColor2,
    );
  }

  Widget buildForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        buildContactText(),
        Utility.sizedBox(height: 40.0),
        buildTextFieldRow('Full Name', 'Email Address'),
        Utility.sizedBox(height: 20.0),
        buildTextFieldRow('Mobile Number', 'Email Subject'),
        Utility.sizedBox(height: 20.0),
        buildMessageField(),
        Utility.sizedBox(height: 40.0),
        AppButtons.buildMaterialButton(
          buttonName: 'Send Message', onTap: () {},
        ),
        Utility.sizedBox(height: 30.0),
      ],
    );
  }

  Widget buildTextFieldRow(String hintText1, String hintText2) {
    return Row(
      children: [
        Expanded(
          child: buildTextField(hintText: hintText1),
        ),
        Utility.sizedBox(width: 20.0),
        Expanded(
          child: buildTextField(hintText: hintText2),
        ),
      ],
    );
  }

  Widget buildTextField({required String hintText}) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.transparent,
      elevation: 8,
      child: TextField(
        cursorColor: AppColors.white,
        style: AppTextStyles.normalStyle(),
        decoration: buildInputDecoration(hintText: hintText),
      ),
    );
  }

  Widget buildMessageField() {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.transparent,
      elevation: 8,
      child: TextField(
        maxLines: 15,
        cursorColor: AppColors.white,
        style: AppTextStyles.normalStyle(),
        decoration: buildInputDecoration(hintText: 'Your Message'),
      ),
    );
  }

  Widget buildContactText() {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1200),
      builder: (context, double opacity, child) {
        return Opacity(
          opacity: opacity,
          child: RichText(
            text: TextSpan(
              text: 'Contact ',
              style: AppTextStyles.headingStyles(fontSize: 30.0),
              children: [
                TextSpan(
                  text: 'Us!',
                  style: AppTextStyles.headingStyles(
                      fontSize: 30, color: AppColors.bgColor2),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  InputDecoration buildInputDecoration({required String hintText}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppTextStyles.comfortaaStyle(),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      filled: true,
      fillColor: AppColors.bgColor2,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    );
  }
}
