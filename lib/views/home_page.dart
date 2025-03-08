import 'dart:async';
import 'package:flutter/material.dart';
import 'package:soft_rise/globals/app_buttons.dart';
import 'package:soft_rise/globals/app_colors.dart';
import 'package:soft_rise/globals/app_text_styles.dart';
import 'package:soft_rise/globals/utility.dart';
import 'package:soft_rise/helper%20class/helper_class.dart';
import 'package:soft_rise/widgets/profile_animation.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onScrollToContact;

  const HomePage({required this.onScrollToContact, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  late String _displayedText;
  late int _charIndex;
  late int _currentTextIndex;
  late Timer _typingTimer;
  bool _isTypingCompleted = false;

  final List<String> _textsToDisplay = [
    'Mobile App Development.',
    'Web Development.',
    'Performance Optimization.'
  ];

  @override
  void initState() {
    super.initState();

    // Initialize the animation controllers for fade and slide
    _fadeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400));
    _slideController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut));
    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.5), end: Offset.zero).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeInOut));

    _displayedText = '';
    _charIndex = 0;
    _currentTextIndex = 0;

    // Start the animations
    _fadeController.forward();
    _slideController.forward();

    // Start typing effect
    _startTypingEffect();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _typingTimer.cancel(); // Cancel the timer when disposing
    super.dispose();
  }

  // Function to simulate typing effect with proper timing
  void _startTypingEffect() {
    const duration = Duration(milliseconds: 150); // Typing speed, slower typing

    _typingTimer = Timer.periodic(duration, (timer) {
      if (_charIndex < _textsToDisplay[_currentTextIndex].length) {
        setState(() {
          _displayedText += _textsToDisplay[_currentTextIndex][_charIndex];
          _charIndex++;
        });
      } else {
        // Once one text is fully displayed, prepare for the next text after a delay
        _isTypingCompleted = true;
        _typingTimer.cancel(); // Stop the current timer
        Future.delayed(const Duration(seconds: 2), () { // Add delay after each complete text
          if (_isTypingCompleted) {
            setState(() {
              _currentTextIndex = (_currentTextIndex + 1) % _textsToDisplay.length; // Cycle through texts
              _displayedText = ''; // Clear current text
              _charIndex = 0; // Reset character index
              _isTypingCompleted = false; // Reset typing completion flag
            });
            _startTypingEffect(); // Start typing next text
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return HelperClass(
      mobile: buildMobileLayout(size),
      tablet: buildTabletLayout(size),
      desktop: buildDesktopLayout(size),
      paddingWidth: size.width * 0.1,
      bgColor: AppColors.appBarColor,
      bgColor1: AppColors.appBarColor1,
      bgColor2: AppColors.appBarColor2,
    );
  }

  // Mobile layout
  Column buildMobileLayout(Size size) {
    return Column(
      children: [
        buildHomePersonalInfo(size),
        Utility.sizedBox(height: 25.0),
        ProfileAnimation(
          profilePictureWidth: 150.0, // Mobile width
          profilePictureHeight: 130.0, // Mobile height
          backgroundWidth: 400.0, // Mobile background width
          backgroundHeight: 350.0, // Mobile background height
          socialIconsWidth: 100.0, // Mobile social icons width
          socialIconsHeight: 100.0, // Mobile social icons height
          containerHeight: 200.0,
          containerWidth: 450.0,
        ),
      ],
    );
  }

  // Tablet layout
  Row buildTabletLayout(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(child: buildHomePersonalInfo(size)),
        ProfileAnimation(
          profilePictureWidth: 250.0, // Tablet width
          profilePictureHeight: 200.0, // Tablet height
          backgroundWidth: 500.0, // Tablet background width
          backgroundHeight: 400.0, // Tablet background height
          socialIconsWidth: 150.0, // Tablet social icons width
          socialIconsHeight: 150.0, // Tablet social icons height
          containerHeight: 270.0,
          containerWidth: 520.0,
        ),
      ],
    );
  }

  // Desktop layout
  Row buildDesktopLayout(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(child: buildHomePersonalInfo(size)),
        ProfileAnimation(
          profilePictureWidth: 250.0, // Desktop width
          profilePictureHeight: 200.0, // Desktop height
          backgroundWidth: 500.0, // Desktop background width
          backgroundHeight: 400.0, // Desktop background height
          socialIconsWidth: 150.0, // Desktop social icons width
          socialIconsHeight: 150.0, // Desktop social icons height
          containerHeight: 270.0,
          containerWidth: 520.0,
        ),
      ],
    );
  }

  // Reusable widget for personal info section
  Column buildHomePersonalInfo(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        buildFadeInText(
          'Welcome to SoftRise',
          AppTextStyles.headingStyles(),
          1400,
        ),
        Utility.sizedBox(height: 45.0),
        buildFadeInText(
          'Your partner in innovative software solutions for',
          AppTextStyles.montserratStyle(color: Colors.white),
          1400,
        ),
        buildTypingEffectText(),
        Utility.sizedBox(height: 18.0),
        buildContactUsButton(),
      ],
    );
  }

  // Helper function for building fade-in text using AnimatedOpacity
  Widget buildFadeInText(String text, TextStyle style, int duration) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }

  // Function to display typing effect text for each phrase in the cycle
  Widget buildTypingEffectText() {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Text(
          _displayedText,
          style: AppTextStyles.montserratStyle(color: AppColors.bgColor2),
        ),
      ),
    );
  }

  // Reusable Contact Us button with action
  Widget buildContactUsButton() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: AppButtons.buildMaterialButton(
          onTap: () {
            widget.onScrollToContact();
          },
          buttonName: 'Contact Us',
        ),
      ),
    );
  }
}
