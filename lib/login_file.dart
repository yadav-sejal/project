import 'package:flutter/material.dart';
import 'package:plant_app/SignUpScreen.dart';
import 'DashBoardScreen.dart'; // This is where the user will be navigated after successful login

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // You can implement authentication logic here
  void _login() {
    // Check for valid email and password
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      // Proceed to dashboard screen after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashBoardScreen()),
      );
    } else {
      // Show a simple error message for invalid input
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in both fields.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center( // Center all content in the middle of the screen
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
              SizedBox(height: 40), // Space between password field and button

              // Login button inside the container with ellipse shape
              ElevatedButton(
                onPressed: _login,
                child: Text("Login"),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Colors.blue, // Customize the button color
                  minimumSize: Size(double.infinity, 50), // Make the button full-width
                ),
              ),
              SizedBox(height: 20), // Space between login button and sign-up link

              // Sign Up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpScreen())
                      );
                    },
                    child: Text("Sign Up"),
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
