import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'SettingScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // For File handling
class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  bool isSearching = false; // To toggle the search box visibility
  String searchText = ''; // To store the user's input in the search box

  // For Bottom Navigation Bar
  int _selectedIndex = 0; // To track the selected tab index
  final List<Widget> _pages = [
    HomeScreen(),
    CommunityScreen(),
    SettingsScreen(),
  ];
  File? _image; // To store the picked image

  // Function to pick an image using the camera
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera); // Capture image from camera

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Save the image file
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            children: [
              Icon(Icons.eco, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Plant Care',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Search, Voice, and Profile Container
          Container(
            color: Colors.green.shade100,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Search Box
                Expanded(
                  child: isSearching
                      ? TextField(
                    onChanged: (value) {
                      setState(() {
                        searchText = value; // Update searchText as user types
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Type here...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    ),
                  )
                      : GestureDetector(
                    onTap: () {
                      setState(() {
                        isSearching = true;
                      });
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.search, color: Colors.grey),
                          ),
                          Text(
                            "Search",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                // Voice Icon
                IconButton(
                  icon: Icon(Icons.mic, color: Colors.green),
                  onPressed: () {
                    // Navigate to the VoiceCommandScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VoiceCommandScreen()),
                    );
                  },
                ),
                SizedBox(width: 8),
                // Camera Icon (which will be replaced by image if captured)
                _image == null
                    ? IconButton(
                  icon: Icon(Icons.camera_alt, color: Colors.green),
                  onPressed: _pickImage, // Call _pickImage when camera icon is tapped
                )
                    : GestureDetector(
                  onTap: _pickImage, // Tapping on the image will let you take a new picture
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: FileImage(_image!), // Show the captured image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                // Profile Icon
                GestureDetector(
                  onTap: () {
                    // Navigate to the user profile screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserProfileScreen()),
                    );
                  },
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.green),
                  ),
                ),
              ],
            ),
          ),

          // If image is captured, display image details
          if (_image != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.file(_image!), // Display the captured image
                  SizedBox(height: 8),
                  Text(
                    'Image Details: ${_image!.path.split('/').last}', // Display file name (path part after last '/')
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

          // Remaining Content Placeholder
          Expanded(
            child: _pages[_selectedIndex], // Show the selected page
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Update selected index on tap
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// Home Screen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Community Screen
class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Community Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Settings Screen
class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}
class _SettingsScreenState extends State<SettingsScreen> {
  String _currentLanguage = 'English';  // Default language
  bool _notificationsEnabled = true;  // Default value for notifications
  bool _darkModeEnabled = false;  // Default value for dark mode

  // Method to change language
  void _changeLanguage(String languageCode) {
    setState(() {
      _currentLanguage = languageCode;  // Update language in the state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Notifications
          SwitchListTile(
            title: Text('Enable Notifications'),
            subtitle: Text('Get reminders for watering, fertilizing, etc.'),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
            activeColor: Colors.green,
            inactiveThumbColor: Colors.grey,
          ),

          Divider(color: Colors.grey), // Divider

          // Dark Mode
          SwitchListTile(
            title: Text('Dark Mode'),
            subtitle: Text('Switch between light and dark themes'),
            value: _darkModeEnabled,
            onChanged: (value) {
              setState(() {
                _darkModeEnabled = value;
              });
            },
            activeColor: Colors.green,
            inactiveThumbColor: Colors.grey,
          ),

          Divider(color: Colors.grey), // Divider

          // Language Selection
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            subtitle: Text('Selected Language: $_currentLanguage'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () async {
              // Navigate to Language Selection Page
              final selectedLanguage = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LanguageSelectionPage(),
                ),
              );

              // Update the current language when returning
              if (selectedLanguage != null) {
                _changeLanguage(selectedLanguage);  // Update language in state
              }
            },
          ),

          Divider(color: Colors.grey), // Divider

          // Account Management
          ListTile(
            title: Text('Manage Account'),
            subtitle: Text('Update email or password'),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
            onTap: () {
              // Navigate to account management page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ManageAccountPage()),
              );
            },
          ),

          Divider(color: Colors.grey), // Divider

          // Feedback
          ListTile(
            title: Text('Send Feedback'),
            subtitle: Text('Report bugs or suggest features'),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
            onTap: () {
              // Navigate to feedback form
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FeedbackScreen()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[100], // Light background for the body
    );
  }
}
//camera screen

class CameraService {
  final ImagePicker _picker = ImagePicker();

  // Function to pick an image from the camera
  Future<File?> pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path); // Return the picked image file
    }
    return null; // Return null if no image was picked
  }
}

// Voice Command Screen
class VoiceCommandScreen extends StatefulWidget {
  @override
  _VoiceCommandScreenState createState() => _VoiceCommandScreenState();
}

class _VoiceCommandScreenState extends State<VoiceCommandScreen> {
  stt.SpeechToText _speech = stt.SpeechToText();
  String _text = "Press the mic to speak";

  @override
  void initState() {
    super.initState();
    // Initialize the SpeechToText object.
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      _speech.listen(onResult: (result) {
        setState(() {
          _text = result.recognizedWords; // Update the text with the recognized words.
        });
      });
    } else {
      setState(() {
        _text = "Speech recognition not available";
      });
    }
  }

  void _stopListening() {
    _speech.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Speak"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Button to start listening
            IconButton(
              icon: Icon(Icons.mic, size: 50),
              onPressed: _startListening,
            ),
            // Button to stop listening
            IconButton(
              icon: Icon(Icons.stop, size: 50),
              onPressed: _stopListening,
            ),
            SizedBox(height: 20),
            // Display the recognized text
            Text(
              _text,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}

// User Profile Screen
class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Center(
        child: Text(
          'User Profile Screen',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}




/*

              // Feature Grid
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  FeatureCard(
                    title: 'Diagnosis',
                    icon: Icons.health_and_safety,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaceholderScreen('Diagnosis'),
                        ),
                      );
                    },
                  ),
                  FeatureCard(
                    title: 'Identification',
                    icon: Icons.qr_code_scanner,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PlaceholderScreen('Identification'),
                        ),
                      );
                    },
                  ),
                  FeatureCard(
                    title: 'Tracking',
                    icon: Icons.location_on,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaceholderScreen('Tracking'),
                        ),
                      );
                    },
                  ),
                  FeatureCard(
                    title: 'Community',
                    icon: Icons.people,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaceholderScreen('Community'),
                        ),
                      );
                    },
                  ),
                  FeatureCard(
                    title: 'AR',
                    icon: Icons.view_in_ar,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaceholderScreen('AR'),
                        ),
                      );
                    },
                  ),
                  FeatureCard(
                    title: 'E-commerce',
                    icon: Icons.shopping_cart,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaceholderScreen('E-commerce'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
/*
class FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const FeatureCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.green),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;

  const PlaceholderScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          '$title Screen',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}


*/
/*
class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}
class _DashBoardScreenState extends State<DashBoardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    //HomeScreen(),
    DiagnoseScreen(),
    MyPlantsScreen(),
    CommunityScreen(),
    SettingsScreen(),
  ];

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0 // Show app bar only for HomeScreen
          ? AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            children: [
              Icon(Icons.eco, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Plant Care',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      )
          : null, // No AppBar for other screens

      body: Column(
        children: [
          if (_currentIndex == 0) // Show search bar only for HomeScreen
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Search bar
                    Container(
                      width: 200,
                      child: TextField(
                        controller: _searchController,
                        onChanged: (query) {
                          // Handle search query
                        },
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          prefixIcon: Icon(Icons.search, color: Colors.black),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        // Reminder icon
                        IconButton(
                          icon: Icon(Icons.notifications, color: Colors.black),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReminderScreen(),
                              ),
                            );
                          },
                        ),
                        // User profile icon
                        IconButton(
                          icon: Icon(Icons.person, color: Colors.black),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserProfileScreen(),
                              ),
                            );
                          },
                        ),
                        // Plant scan button
                        IconButton(
                          icon: Icon(Icons.camera_alt, color: Colors.black),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlantScanScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          // The body of the current screen
          Expanded(
            child: _pages[_currentIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Diagnose',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grass),
            label: 'My Plants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// PlantDetailScreen to show details of clicked plant
class PlantDetailScreen extends StatelessWidget {
  final String plantName;

  PlantDetailScreen({required this.plantName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(plantName)),
      body: Center(
        child: Text(
          'Details for $plantName',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
// Placeholder screens for other pages
class DiagnoseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Diagnose Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class MyPlantsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'My Plants Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Community Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _currentLanguage = 'English';
  bool _notificationsEnabled = true; // Default value for notifications
  bool _darkModeEnabled = false; // Default value for dark mode

  // Method to change language
  void _changeLanguage(String languageCode) {
    setState(() {
      _currentLanguage = languageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Notifications
          SwitchListTile(
            title: Text('Enable Notifications'),
            subtitle: Text('Get reminders for watering, fertilizing, etc.'),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
            activeColor: Colors.green,
            inactiveThumbColor: Colors.grey,
          ),

          Divider(color: Colors.grey), // Divider

          // Dark Mode
          SwitchListTile(
            title: Text('Dark Mode'),
            subtitle: Text('Switch between light and dark themes'),
            value: _darkModeEnabled,
            onChanged: (value) {
              setState(() {
                _darkModeEnabled = value;
              });
            },
            activeColor: Colors.green,
            inactiveThumbColor: Colors.grey,
          ),

          Divider(color: Colors.grey), // Divider

          // Language Selection
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language'),
            subtitle: Text('Selected Language: $_currentLanguage'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () async {
              // Navigate to Language Selection Page
              final selectedLanguage = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LanguageSelectionPage(),
                ),
              );

              // Update the current language when returning
              if (selectedLanguage != null) {
                _changeLanguage(selectedLanguage);
              }
            },
          ),

          Divider(color: Colors.grey), // Divider

          // Account Management
          ListTile(
            title: Text('Manage Account'),
            subtitle: Text('Update email or password'),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
            onTap: () {
              // Navigate to account management page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ManageAccountPage()),
              );
            },
          ),

          Divider(color: Colors.grey), // Divider

          // Feedback
          ListTile(
            title: Text('Send Feedback'),
            subtitle: Text('Report bugs or suggest features'),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
            onTap: () {
              // Navigate to feedback form
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FeedbackScreen()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[100], // Light background for the body
    );
  }
}


class ReminderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reminder')),
      body: Center(
        child: Text(
          "Reminder Screen",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: Center(
        child: Text(
          "User Profile Screen",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class PlantScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scan Your Plant')),
      body: Center(
        child: Text(
          "Scan your plant using camera",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
*/