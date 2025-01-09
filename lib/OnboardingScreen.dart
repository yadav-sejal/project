import 'package:flutter/material.dart';
import 'login_file.dart'; // Import the LoginScreen (make sure the file exists)
import 'DashBoardScreen.dart'; // Ensure this file exists and is implemented correctly

// Define a class to hold the onboarding data
class OnboardingData {
  final String title;
  final String description;
  final String image;

  OnboardingData({
    required this.title,
    required this.description,
    required this.image,
  });
}

// Define the onboarding data list
final List<OnboardingData> onboardingData = [
  OnboardingData(
    title: 'Know more about your plant.',
    description:
    'Identify plant disease instantly using AI-powered diagnosis. Just snap a picture!',
    image: 'assets/images/plant_scanner.png',
  ),
  OnboardingData(
    title: 'See How Plants Look at different places',
    description:
    'See how your plants will look and grow using our augmented reality guide.',
    image: 'assets/images/augmentedreality.png',
  ),
  OnboardingData(
    title: 'Smart Reminder and Insights',
    description:
    'Never miss a care task with personalized reminders and health insights.',
    image: 'assets/images/reminder.png',
  ),
  OnboardingData(
    title: 'Community and Sharing',
    description: 'Join a community of plant lovers. Share, learn, and connect.',
    image: 'assets/images/community.png',
  ),
];

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      // Navigate to the Login screen after completing onboarding
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()), // Navigate to LoginScreen
      );
    }
  }

  void _skip() {
    // Skip onboarding and navigate directly to Login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()), // Navigate to LoginScreen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100], // Set background to light green
      body: Column(
        children: [
          // Title with green background
          Container(
            color: Colors.green,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              "Plant Care",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Add space below the "Plant Care" title
          SizedBox(height: 50), // Increased space below the title

          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    // Add space above the image
                    SizedBox(height: 30), // Space before the image

                    // Image
                    Image.asset(
                      onboardingData[index].image,
                      height: 250,
                    ),

                    // Add space after the image
                    SizedBox(height: 30), // Space after the image

                    // Title and Description inside the same box
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white, // White background for text container
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Title in Green and centered
                            Text(
                              onboardingData[index].title,
                              style: TextStyle(
                                color: Colors.green, // Green title color
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center, // Centering the title
                            ),
                            SizedBox(height: 10), // Add space between title and description

                            // Description in Black
                            Text(
                              onboardingData[index].description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black, // Black description color
                                fontSize: 16,
                                height: 1.5, // Line spacing for better readability
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Add space after the box
                    SizedBox(height: 50), // Space after the text box
                  ],
                );
              },
            ),
          ),

          // Bottom navigation controls
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Skip button inside an ellipse
                ElevatedButton(
                  onPressed: _skip,
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Colors.blue, // Blue background for Skip
                  ),
                  child: Text(
                    "Skip",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Row(
                  children: List.generate(
                    onboardingData.length,
                        (dotIndex) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == dotIndex
                            ? Colors.green
                            : Colors.green.shade200,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                // Next/Finish button inside an ellipse
                ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Colors.blue, // Blue background for Next
                  ),
                  child: Text(
                    _currentPage == onboardingData.length - 1
                        ? "Finish"
                        : "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
