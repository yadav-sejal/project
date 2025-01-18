import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'language_provider.dart';  // Import the LanguageProvider
class ManageAccountPage extends StatefulWidget {
  @override
  _ManageAccountPageState createState() => _ManageAccountPageState();
}

class _ManageAccountPageState extends State<ManageAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Account'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Update Email
          ListTile(
            title: Text('Update Email'),
            onTap: () {
              _showUpdateEmailDialog();
            },
          ),
          Divider(),

          // Change Password
          ListTile(
            title: Text('Change Password'),
            onTap: () {
              _showChangePasswordDialog();
            },
          ),
          Divider(),

          // Delete Account
          ListTile(
            title: Text('Delete Account'),
            onTap: () {
              _showDeleteAccountDialog();
            },
          ),
          Divider(),

          // Logout Button
          ElevatedButton(
            onPressed: () {
              _logout();
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  // Show Update Email Dialog
  void _showUpdateEmailDialog() {
    TextEditingController _emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Email'),
          content: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'New Email',
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Handle the email update logic here
                String newEmail = _emailController.text;
                print("Email updated to: $newEmail");
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  // Show Change Password Dialog
  void _showChangePasswordDialog() {
    TextEditingController _oldPasswordController = TextEditingController();
    TextEditingController _newPasswordController = TextEditingController();
    TextEditingController _confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _oldPasswordController,
                decoration: InputDecoration(labelText: 'Old Password'),
                obscureText: true,
              ),
              TextField(
                controller: _newPasswordController,
                decoration: InputDecoration(labelText: 'New Password'),
                obscureText: true,
              ),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_newPasswordController.text == _confirmPasswordController.text) {
                  print("Password changed successfully!");
                } else {
                  print("Passwords do not match.");
                }
                Navigator.of(context).pop();
              },
              child: Text('Change Password'),
            ),
          ],
        );
      },
    );
  }

  // Show Delete Account Dialog
  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: Text('Are you sure you want to delete your account? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                print("Account deleted!");
                Navigator.of(context).pop();
              },
              child: Text('Delete Account'),
            ),
          ],
        );
      },
    );
  }

  // Logout action
  void _logout() {
    print("User logged out");
    Navigator.of(context).pop();  // Go back to previous screen (Settings)
  }
}


//language selection

class LanguageSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Language'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('English'),
            onTap: () {
              Provider.of<LanguageProvider>(context, listen: false)
                  .changeLanguage('en');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Hindi'),
            onTap: () {
              Provider.of<LanguageProvider>(context, listen: false)
                  .changeLanguage('hi');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Marathi'),
            onTap: () {
              Provider.of<LanguageProvider>(context, listen: false)
                  .changeLanguage('mr');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

//feedback

class FeedbackScreen extends StatelessWidget {
  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'We value your feedback! Please provide your thoughts below.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _feedbackController,
              decoration: InputDecoration(
                labelText: 'Enter your feedback',
                border: OutlineInputBorder(),
                hintText: 'Type your feedback here...',
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String feedback = _feedbackController.text;
                if (feedback.isNotEmpty) {
                  // Handle feedback submission (e.g., save to a server or send email)
                  // For now, just print it to the console
                  print("User Feedback: $feedback");

                  // Show a confirmation message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Feedback submitted successfully!')),
                  );
                } else {
                  // Show a warning if the feedback is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter your feedback.')),
                  );
                }
              },
              child: Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }
}

