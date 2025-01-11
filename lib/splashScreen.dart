import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plant_app/OnboardingScreen.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delayed navigation after 5 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF014C07), // Updated to fully opaque color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add an icon instead of an image
              Icon(
                Icons.eco, // Plant leaf icon
                color: Colors.greenAccent,
                size: 100, // Adjust icon size
              ),
              SizedBox(height: 20), // Spacing between icon and text

              // Add styled text
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Plant",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // White color for "Plant"
                      ),
                    ),
                    TextSpan(
                      text: " Care",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent, // Green accent for "Care"
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
