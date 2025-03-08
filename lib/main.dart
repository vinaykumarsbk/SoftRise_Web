import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_rise/constants.dart';
import 'package:soft_rise/views/dashboard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Used to validate certificates for local development.
class LocalHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  runApp(const MyApp());
  /// Used to validate certificates for local development
  HttpOverrides.global = LocalHttpOverrides();
  await Supabase.initialize(
    url: Constants.supabaseUrl,
    anonKey: Constants.supabaseAnnonKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soft Rise',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme,),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DashBoard(),
    );
  }
}
