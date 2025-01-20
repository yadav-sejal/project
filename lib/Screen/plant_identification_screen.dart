import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart'; // To handle permissions

class PlantIdentificationScreen extends StatefulWidget {
  @override
  _PlantIdentificationScreenState createState() =>
      _PlantIdentificationScreenState();
}

class _PlantIdentificationScreenState extends State<PlantIdentificationScreen> {
  File? _image;
  String? plantName;
  bool isIdentifying = false; // To track the identification status

  // Request permission for camera
  Future<void> _requestPermission() async {
    PermissionStatus status = await Permission.camera.request();

    if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera permission is denied.')),
      );
    } else if (status.isGranted) {
      // If permission is granted, proceed with picking an image
      _identifyPlant();
    } else if (status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera permission is permanently denied. Please go to settings and enable it.')),
      );
    }
  }

  // Identify plant from image
  Future<void> _identifyPlant() async {
    // Request permission before accessing the camera
    await _requestPermission();

    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        isIdentifying = true; // Start identifying plant
      });

      try {
        // Call identification service
        plantName = await PlantIdentificationService.identifyPlant(_image!);
      } catch (e) {
        plantName = 'Identification failed. Please try again.';
      } finally {
        setState(() {
          isIdentifying = false; // End identification
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Identification'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _image == null
                  ? Text(
                'No image selected.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              )
                  : Image.file(
                _image!,
                height: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              isIdentifying
                  ? CircularProgressIndicator() // Show progress indicator during identification
                  : ElevatedButton(
                onPressed: _requestPermission, // Request permission first
                child: Text('Identify Plant'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              SizedBox(height: 20),
              if (plantName != null)
                Text(
                  'Plant Identified: $plantName',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder for the actual plant identification service
class PlantIdentificationService {
  static Future<String> identifyPlant(File image) async {
    // Simulate an API call or use any service to identify the plant
    try {
      await Future.delayed(Duration(seconds: 2)); // Simulate a delay
      return 'Rose'; // Returning a dummy plant name for now
    } catch (e) {
      throw Exception('Plant identification failed');
    }
  }
}
