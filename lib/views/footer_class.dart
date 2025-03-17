import 'package:flutter/material.dart';
import 'package:soft_rise/constants.dart';
import 'package:soft_rise/globals/app_colors.dart';
import 'package:soft_rise/globals/app_text_styles.dart';
import 'package:soft_rise/globals/utility.dart';

class FooterClass extends StatelessWidget {
  const FooterClass({super.key});

  @override
  Widget build(BuildContext context) {

    // Increase only the right-side padding here
    final double leftPadding = 40.0; // Keep original left padding
    final double rightPadding = 60.0; // Increase right-side padding to prevent overlap

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryLightColor,
            AppColors.appBarColor1,
            AppColors.appBarColor2
          ],
          begin: FractionalOffset(1.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 0.0, 0.0],
          tileMode: TileMode.clamp,
        ),
      ), // Background color
      padding: EdgeInsets.only(left: leftPadding, right: rightPadding, top: 20, bottom: 20), // Custom padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left section: Company name, tagline, and copyright text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company name and tagline
              Text(
                'SoftRise',
                style: AppTextStyles.headingStyles().copyWith(fontSize: 24),
              ),
              const SizedBox(height: 8),
              Text(
                'Innovation Meets Growth',
                style: AppTextStyles.montserratStyle(color: Colors.white).copyWith(fontSize: 14),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _buildSocialIcons(),
              ),
              const SizedBox(height: 16),

              // Copyright Text
              Text(
                '© SoftRise 2025 All rights reserved.',
                style: AppTextStyles.normalStyle(color: Colors.white).copyWith(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper function to build social media icons dynamically from the list
  List<Widget> _buildSocialIcons() {
    List<Widget> socialIcons = [];
    for (var socialItem in Constants.social) {
      socialIcons.add(
        GestureDetector(
          onTap: () => Utility.launchURL(socialItem['link']),
          child: Icon(
            socialItem['icon'],
            color: Colors.white,
            size: 28, // Scale icon size based on screen width
          ),
        ),
      );
      socialIcons.add(const SizedBox(width: 13)); // Add spacing between icons
    }
    return socialIcons;
  }
}
