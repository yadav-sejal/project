import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'SettingScreen.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:tflite_flutter/tflite_flutter.dart';
//import 'dart:typed_data';
//import 'package:image/image.dart' as img;
import 'dart:io';
import 'community_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';


class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  bool isSearching = false;
  String searchText = '';
  int _selectedIndex = 0; // To track the selected tab index
  final List<Widget> _pages = [
    HomeScreen(), // Home Screen will include Care Recommendations clickable box
    // PlantDiagnosisScreen(),   // Plant Diagnosis Screen
    MyPlantScreen(),
    CommunityScreen(),
    SettingsScreen(),
  ];

  File? _image; // To store the picked image

  // Function to pick an image using the camera
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

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
        title: Row(
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
      body: Column(
        children: [
          if (_selectedIndex == 0) // Show this only when Home Screen is active
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Search, Voice, Camera, and Profile section
                  Row(
                    children: [
                      // Search Box
                      Expanded(
                        child: isSearching
                            ? TextField(
                          onChanged: (value) {
                            setState(() {
                              searchText =
                                  value; // Update searchText as user types
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
                          // Implement voice functionality
                        },
                      ),
                      SizedBox(width: 8),
                      // Camera Icon
                      _image == null
                          ? IconButton(
                        icon: Icon(Icons.camera_alt, color: Colors.green),
                        onPressed: _pickImage, // Call _pickImage when camera icon is tapped
                      )
                          : GestureDetector(
                        onTap: _pickImage,
                        // Tapping on the image lets you take a new picture
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: FileImage(_image!),
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
                            MaterialPageRoute(builder: (context) =>
                                UserProfileScreen()),
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
                ],
              ),
            ),
          // Remaining Content
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
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          /*  BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital),
          label:'Diagnosis',
          ),*/
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist),
            label: 'My Plants',
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
  final List<String> imagePaths = [
    'assets/images/snakeplant.jpg',
    'assets/images/pothos.jpg',
    'assets/images/rubberplant.jpg',
    'assets/images/Calatheamakoyanaplant.jpg',
    'assets/images/swisscheeseplant.jpg',
  ];

  final List<Map<String, dynamic>> featureCards = [
    {
      'title': 'Plant Diagnosis',
      'description': 'Diagnose any plant issues here.',
      'icon': Icons.local_florist,
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlantDiagnosisScreen()),
        );
      },
    },
    {
      'title':'Care Recommendation',
      'description':'care of plants.',
      'icon':Icons.eco,
    'onTap':(BuildContext context){
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>CareRecommendationScreen()),
    );
    },
    },
    {
      'title': 'Growth Tracking',
      'description': 'Track your plant’s growth progress.',
      'icon': Icons.show_chart,
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GrowthTrackingScreen()),
        );
      },
    },
    {
      'title': 'Marketplace',
      'description': 'Explore plant accessories and products.',
      'icon': Icons.shopping_cart,
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MarketplaceScreen()),
        );
      },
    },
    {
      'title': 'Weather',
      'description': 'Check the weather for optimal plant care.',
      'icon': Icons.wb_sunny,
      'onTap': (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WeatherScreen()),
        );
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Popular Heading
          Text(
            'Popular',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),

          // Image Carousel
          CarouselSlider(
            items: imagePaths.map((path) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  path,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.8,
            ),
          ),
          SizedBox(height: 16),

          // Features Grid
          Expanded(
            child: GridView.count(
              crossAxisCount: 2, // 2 items per row
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: featureCards.map((card) {
                return GestureDetector(
                  onTap: () => card['onTap'](context),
                  child: squareCard(
                    card['title'],
                    card['description'],
                    card['icon'],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable function to create square cards
  Widget squareCard(String title, String description, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.green, size: 40),
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

//care recommendation
class CareRecommendationScreen extends StatefulWidget {
  @override
  _CareRecommendationScreenState createState() =>
      _CareRecommendationScreenState();
}

class _CareRecommendationScreenState extends State<CareRecommendationScreen> {
  bool isSearching = false;
  String searchText = '';
  File? _image;

  // Example plant care details for popular plants
  final List<Map<String, String>> plantCareDetails = [
    {
      'plant': 'Rose',
      'care': 'Water every 2-3 days and ensure it gets full sunlight.',
    },
    {
      'plant': 'Tulip',
      'care': 'Water once a week and keep in moderate sunlight.',
    },
    {
      'plant': 'Cactus',
      'care': 'Water sparingly, only when the soil is dry.',
    },
  ];

  // Initialize the speech-to-text object
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false; // To track if the mic is currently listening
  String _micText = ''; // To store the text from voice recognition

  // Function to pick an image using the camera
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Save the image file
      });
    }
  }

  // Function to start listening via the mic
  void _startListening() async {
    bool available = await _speech.initialize(); // Initialize speech recognition

    if (available) {
      setState(() {
        _isListening = true;
      });

      _speech.listen(onResult: (result) {
        setState(() {
          _micText = result.recognizedWords; // Update the recognized words
          searchText = _micText; // Update searchText for the user to see
        });
      });
    } else {
      print("Speech recognition not available");
    }
  }

  // Function to stop listening
  void _stopListening() {
    setState(() {
      _isListening = false;
    });
    _speech.stop(); // Stop listening
  }

  @override
  void dispose() {
    super.dispose();
    _speech.stop(); // Stop the speech listener when the screen is disposed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Plant Care Recommendations'),
      ),
      body: Column(
        children: [
          // Search, Mic, and Camera icons
          Padding(
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
                      hintText: 'Type plant name...',
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
                  icon: Icon(
                    _isListening ? Icons.mic_off : Icons.mic,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    if (_isListening) {
                      _stopListening(); // Stop listening if already listening
                    } else {
                      _startListening(); // Start listening if not listening
                    }
                  },
                ),
                SizedBox(width: 8),
                // Camera Icon
                _image == null
                    ? IconButton(
                  icon: Icon(Icons.camera_alt, color: Colors.green),
                  onPressed: _pickImage,
                )
                    : GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: FileImage(_image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Display Care Recommendations for Plants
          Expanded(
            child: ListView.builder(
              itemCount: plantCareDetails.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  elevation: 5,
                  child: ListTile(
                    leading: Icon(Icons.local_florist, color: Colors.green),
                    title: Text(
                      plantCareDetails[index]['plant']!,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      plantCareDetails[index]['care']!,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
class PlantDiagnosisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plant Diagnosis')),
      body: Center(child: Text('Diagnose your plant issues here.')),
    );
  }
}

class GrowthTrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Growth Tracking')),
      body: Center(child: Text('Track your plant growth here.')),
    );
  }
}

class MarketplaceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Marketplace')),
      body: Center(child: Text('Explore plant products and accessories here.')),
    );
  }
}

class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather')),
      body: Center(child: Text('Check the weather for optimal plant care.')),
    );

  }
}

//diagnosis

/*
class PlantDiagnosisScreen extends StatefulWidget {
  @override
  _PlantDiagnosisScreenState createState() => _PlantDiagnosisScreenState();
}

class _PlantDiagnosisScreenState extends State<PlantDiagnosisScreen> {
  late Interpreter _interpreter; // Declare the Interpreter
  String diagnosisResult = ''; // Store diagnosis result
  File? _image; // Store the picked image

  // Load the model into the Interpreter
  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/plant_disease_model.tflite');
      print("Model Loaded Successfully");
    } catch (e) {
      print("Error loading model: $e");
    }
  }

  // Pick an image from the camera
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        diagnosisResult = 'Diagnosing...'; // Temporary message while diagnosing
      });

      // Run the diagnosis after picking the image
      await diagnosePlant(_image!);
    }
  }

  // Preprocess the image before passing it to the model

  Future<List<List<List<List<double>>>>> _preprocessImage(File image) async {
    // Read the image file as bytes
    List<int> imageBytes = await image.readAsBytes();

    // Decode the image using the image package
    img.Image? imgLib = img.decodeImage(Uint8List.fromList(imageBytes));

    // Ensure the image is decoded successfully before processing
    if (imgLib == null) {
      throw Exception("Image decoding failed");
    }

    // Resize the image to 224x224 (or the input size of your model)
    imgLib = imgLib.resize(224, 224);

    // Initialize the tensor as a flattened list to store the RGB values
    List<double> tensor = [];

    // Normalize the RGB values of each pixel and flatten them into the tensor
    for (int y = 0; y < imgLib.height; y++) {
      for (int x = 0; x < imgLib.width; x++) {
        int pixel = imgLib.getPixel(x, y);
        int r = img.getRed(pixel);
        int g = img.getGreen(pixel);
        int b = img.getBlue(pixel);

        // Normalize each color value between 0 and 1
        tensor.add(r / 255.0); // Red channel
        tensor.add(g / 255.0); // Green channel
        tensor.add(b / 255.0); // Blue channel
      }
    }

    // Return the flattened tensor as a list wrapped in a 4D list
    return [
      [
        [tensor], // Wrap the tensor in the correct dimensions [1, 224, 224, 3]
      ]
    ];
  }

  // Run inference using the TensorFlow Lite model
  Future<void> diagnosePlant(File image) async {
    List<List<List<List<double>>>> input = await _preprocessImage(image);

    // Create an output array that fits your model's expected output
    var output = List.filled(1, 0.0); // Adjust the output based on the model's requirements

    try {
      // Run the model on the input image
      _interpreter.run(input, output);

      setState(() {
        diagnosisResult = "Diagnosis: " + output[0].toString(); // Display the result
      });
    } catch (e) {
      print("Error during model inference: $e");
      setState(() {
        diagnosisResult = "Error during diagnosis!";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadModel(); // Load the model when the screen initializes
  }

  @override
  void dispose() {
    _interpreter.close(); // Close the interpreter to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Diagnosis'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Scan button/icon to pick an image
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 120,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Scan Plant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Show the picked image and diagnosis result
          if (_image != null) ...[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.file(_image!, height: 200, fit: BoxFit.cover),
                  SizedBox(height: 8),
                  Text('Plant Image', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 16),
                  Text(diagnosisResult, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],

          // Show instructions if no image is picked
          if (_image == null) ...[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Tap the button above to scan a plant image for diagnosis.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
*/
//my plants

class MyPlantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'My Plants',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
// Community Screen


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



