import 'package:flutter/material.dart';
import 'package:soft_rise/globals/app_assets.dart';
import 'package:soft_rise/globals/app_buttons.dart';
import 'package:soft_rise/globals/app_colors.dart';
import 'package:soft_rise/globals/app_text_styles.dart';
import 'package:soft_rise/globals/utility.dart';
import 'package:soft_rise/helper%20class/helper_class.dart';

class OurServices extends StatefulWidget {
  const OurServices({super.key});

  @override
  State<OurServices> createState() => _MyServicesState();
}

class _MyServicesState extends State<OurServices> {
  bool isApp = false, isWeb = false, isPerformance = false;

  final onHoverActive = Matrix4.identity()..translate(0, -10, 0);
  final onHoverRemove = Matrix4.identity()..translate(0, 0, 0);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return HelperClass(
      mobile: Column(
        children: [
          buildAnimatedTitle(),
          Utility.sizedBox(height: 60.0),
          buildServiceCard('Mobile App Development', 'Native iOS and Android apps built with cutting-edge technology', AppAssets.code, isApp, (value) => setState(() => isApp = value)),
          Utility.sizedBox(height: 24.0),
          buildServiceCard('Web Development', 'Responsive, modern websites and web applications', AppAssets.web, isWeb, (value) => setState(() => isWeb = value)),
          Utility.sizedBox(height: 24.0),
          buildServiceCard('Performance Optimization', 'Enhance speed and efficiency of your digital products', AppAssets.performance, isPerformance, (value) => setState(() => isPerformance = value)),
        ],
      ),
      tablet: Column(
        children: [
          buildAnimatedTitle(),
          Utility.sizedBox(height: 60.0),
          // Use Wrap instead of Row to better handle overflow
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: size.width),
              child: Wrap(
                spacing: 24.0, // space between cards
                runSpacing: 24.0, // space between rows
                children: [
                  buildServiceCard('Mobile App Development', 'Native iOS and Android apps built with cutting-edge technology', AppAssets.code, isApp, (value) => setState(() => isApp = value)),
                  buildServiceCard('Web Development', 'Responsive, modern websites and web applications', AppAssets.web, isWeb, (value) => setState(() => isWeb = value)),
                ],
              ),
            ),
          ),
          Utility.sizedBox(height: 26.0),
          buildServiceCard('Performance Optimization', 'Enhance speed and efficiency of your digital products', AppAssets.performance, isPerformance, (value) => setState(() => isPerformance = value)),
        ],
      ),
      desktop: Column(
        children: [
          buildAnimatedTitle(),
          Utility.sizedBox(height: 60.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildServiceCard('Mobile App Development', 'Native iOS and Android apps built with cutting-edge technology', AppAssets.code, isApp, (value) => setState(() => isApp = value)),
              Utility.sizedBox(width: 24.0),
              buildServiceCard('Web Development', 'Responsive, modern websites and web applications', AppAssets.web, isWeb, (value) => setState(() => isWeb = value)),
              Utility.sizedBox(width: 24.0),
              buildServiceCard('Performance Optimization', 'Enhance speed and efficiency of your digital products', AppAssets.performance, isPerformance, (value) => setState(() => isPerformance = value)),
            ],
          ),
        ],
      ),
      paddingWidth: size.width * 0.04,
      bgColor: AppColors.appBarColor,
      bgColor1: AppColors.appBarColor1,
      bgColor2: AppColors.appBarColor2,
    );
  }

  /// Animated title using Flutter's FadeTransition.
  Widget buildAnimatedTitle() {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1200),
      builder: (context, double opacity, child) {
        return Opacity(
          opacity: opacity,
          child: RichText(
            text: TextSpan(
              text: 'Our ',
              style: AppTextStyles.headingStyles(fontSize: 30.0),
              children: [
                TextSpan(
                  text: 'Services',
                  style: AppTextStyles.headingStyles(
                      fontSize: 30.0, color: AppColors.bgColor2),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds a service card widget with hover animation.
  Widget buildServiceCard(
      String title, String text, String asset, bool hover, Function(bool) onHover) {
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
          color: AppColors.primaryLightColor,
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
              text,
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
}
