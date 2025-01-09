import 'package:flutter/material.dart';
import 'package:plant_app/login_file.dart';
import 'DashBoardScreen.dart'; // Navigate to this screen after sign-up completion

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Sign-up logic
  void _signUp() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _passwordController.text == _confirmPasswordController.text) {
      // Proceed to the dashboard after successful sign-up
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashBoardScreen()),
      );
    } else {
      // Show an error message if passwords don't match or fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields or check passwords.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center( // Center all content in the middle of the screen
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Center the content horizontally
            children: [
              // Email label and input field inside ellipse shape
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Email", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 8), // Space between label and input field
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 6),
                  ],
                ),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 20), // Space between email and password fields

              // Password label and input field inside ellipse shape
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Password", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 8), // Space between label and input field
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 6),
                  ],
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 20), // Space between password and confirm password fields

              // Confirm Password label and input field inside ellipse shape
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Confirm Password", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 8), // Space between label and input field
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, blurRadius: 6),
                  ],
                ),
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Confirm your password",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 40), // Space between confirm password field and button

              // Sign Up button inside the container with ellipse shape
              ElevatedButton(
                onPressed: _signUp,
                child: Text("Sign Up"),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Colors.blue, // Customize the button color
                  minimumSize: Size(double.infinity, 50), // Make the button full-width
                ),
              ),
              SizedBox(height: 20), // Space between sign-up button and login link

              // Login link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen())
                      );
                    },
                    child: Text("Login"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
