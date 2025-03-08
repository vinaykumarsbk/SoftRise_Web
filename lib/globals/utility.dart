import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Utility {
  static SizedBox sizedBox({height, width}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  // Function to launch URL using url_launcher
  static Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
