import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plant_app/OnboardingScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController for rotation
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3), // Same as the splash screen duration
    )..repeat(); // Repeat animation indefinitely

    // Delayed navigation after 3 seconds
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
  void dispose() {
    _controller.dispose(); // Dispose controller to free up resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF014C07), // Fully opaque green background
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Rotating icon
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _controller.value * 2 * 3.1416, // Full rotation
                    child: child,
                  );
                },
                child: Icon(
                  Icons.eco, // Plant leaf icon
                  color: Colors.greenAccent,
                  size: 100, // Adjust icon size
                ),
              ),
              SizedBox(height: 20), // Spacing between icon and text

              // Styled text
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
