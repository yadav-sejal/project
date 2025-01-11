import 'package:flutter/material.dart';
import 'package:plant_app/splashScreen.dart';
import 'splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),

    );

  }
}
