import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);

const double defaultPadding = 16.0;

const double loginFieldsPadding = 16.0;


/// Environment variables and shared app constants.
abstract class Constants {
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: '',
  );

  static const String supabaseAnnonKey = String.fromEnvironment(
    'SUPABASE_ANNON_KEY',
    defaultValue: '',
  );

  static const List<Map<String, dynamic>> social = [
    {
      'icon': FontAwesomeIcons.github,  // Font Awesome GitHub Icon
      'link': 'https://github.com',
    },
    {
      'icon': FontAwesomeIcons.linkedin,  // Font Awesome LinkedIn Icon
      'link': 'https://linkedin.com',
    },
    {
      'icon': FontAwesomeIcons.xTwitter,  // Font Awesome Twitter Icon
      'link': 'https://x.com',
    },
    {
      'icon': FontAwesomeIcons.facebook,  // Font Awesome Facebook Icon
      'link': 'https://facebook.com',
    },
  ];
}