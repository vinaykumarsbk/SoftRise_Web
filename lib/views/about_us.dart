import 'package:flutter/material.dart';
import 'package:soft_rise/globals/app_colors.dart';
import 'package:soft_rise/globals/app_text_styles.dart';
import 'package:soft_rise/globals/utility.dart';
import 'package:soft_rise/helper%20class/helper_class.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;

  @override
  void initState() {
    super.initState();

    // Initialize Animation Controllers for fade and slide animations
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return HelperClass(
      mobile: buildMobileLayout(),
      tablet: buildTabletLayout(),
      desktop: buildDesktopLayout(),
      paddingWidth: size.width * 0.1,
      bgColor: AppColors.primaryLightColor,
      bgColor1: AppColors.appBarColor1,
      bgColor2: AppColors.appBarColor2,
    );
  }

  // Mobile layout
  Column buildMobileLayout() {
    return Column(
      children: [
        buildAboutMeContents(),
        Utility.sizedBox(height: 35.0),
      ],
    );
  }

  // Tablet layout
  Row buildTabletLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: buildAboutMeContents())
      ],
    );
  }

  // Desktop layout
  Row buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: buildAboutMeContents())
      ],
    );
  }

  // Reusable widget for About Me Contents section
  Column buildAboutMeContents() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        buildRichText(),
        Utility.sizedBox(height: 6.0),
        buildTextContent(),
        Utility.sizedBox(height: 15.0),
      ],
    );
  }

  // RichText widget for title
  Widget buildRichText() {
    return FadeTransition(
      opacity: _fadeController,
      child: SlideTransition(
        position: _slideController.drive(Tween<Offset>(begin: Offset(0, 0.5), end: Offset.zero)),
        child: RichText(
          text: TextSpan(
            text: 'About ',
            style: AppTextStyles.headingStyles(fontSize: 30.0),
            children: [
              TextSpan(
                text: 'Us!',
                style: AppTextStyles.headingStyles(
                    fontSize: 30, color: AppColors.bgColor2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Text content for the about section
  Widget buildTextContent() {
    return FadeTransition(
      opacity: _fadeController,
      child: SlideTransition(
        position: _slideController.drive(Tween<Offset>(begin: Offset(0, 0.5), end: Offset.zero)),
        child: Column(
          children: [
            _buildText(
              'At Softrise, we specialize in delivering comprehensive digital solutions tailored to your business needs. Our expertise spans mobile development, web development, and performance enhancements, ensuring that your applications are not only functional but also optimized for superior user experiences.',
            ),
            _buildHeadingText('Mobile Development'),
            _buildText(
              'We create intuitive and high-performing mobile applications for both iOS and Android platforms. Our development process focuses on delivering seamless user experiences, fast load times, and efficient resource usage.',
            ),
            _buildHeadingText('Web Development'),
            _buildText(
              'Our web development services encompass the creation of responsive and user-friendly websites and web applications. We employ modern frameworks and technologies to build scalable and secure web solutions that align with your business objectives.',
            ),
            _buildHeadingText('Performance Enhancements'),
            _buildText(
              'We focus on optimizing the performance of your applications to provide users with fast, responsive, and reliable experiences. Our performance enhancement strategies include code optimization, resource management, and load time reduction, all aimed at improving the efficiency and speed of your applications.',
            ),
          ],
        ),
      ),
    );
  }

  // Helper function for regular text
  Widget _buildText(String text) {
    return Text(
      text,
      style: AppTextStyles.normalStyle(),
    );
  }

  // Helper function for headings
  Widget _buildHeadingText(String heading) {
    return Align(
      alignment: Alignment.centerLeft, // Right-align the heading
      child: Text(
        heading,
        style: AppTextStyles.montserratStyle(color: Colors.white, fontSize: 22.0),
      ),
    );
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Start animations after widget is built
    _fadeController.forward();
    _slideController.forward();
  }
}
