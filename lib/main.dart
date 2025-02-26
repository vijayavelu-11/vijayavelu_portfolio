import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vijayavelu_portfolio/pages/splitpage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplitScreenLayout(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(),
      ),
    );
  }
}
