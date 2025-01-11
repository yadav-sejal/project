import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    DiagnoseScreen(),
    MyPlantsScreen(),
    CommunityScreen(),
    SettingsScreen(),
  ];

  TextEditingController _searchController = TextEditingController();

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
class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> plantList = [
    {'image': 'assets/images/snakeplant.jpg', 'name': 'Snake Plant'},
    {'image': 'assets/images/Calatheamakoyanaplant.jpg', 'name': 'Calathea Makoyana'},
    {'image': 'assets/images/pothos.jpg', 'name': 'Pothos'},
    {'image': 'assets/images/rubberplant.jpg', 'name': 'Rubber Plant'},
    {'image': 'assets/images/swisscheeseplant.jpg', 'name': 'Swiss Cheese Plant'},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category filters (Horizontal Scroll)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // Mapping the categories to their corresponding screens
                'ALL', 'INDOOR', 'OUTDOOR', 'SEASONAL', 'TRENDING',
                'RARE', 'HERBS', 'FLOWERING', 'EASY CARE',
              ].map((filter) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to the corresponding screen when a filter is clicked
                      switch (filter) {
                        case 'ALL':
                          break;
                        case 'INDOOR':
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => IndoorPlantsScreen()),
                          );
                          break;
                        case 'OUTDOOR':
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OutdoorPlantsScreen()),
                          );
                          break;
                        case 'SEASONAL':
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SeasonalPlantsScreen()),
                          );
                          break;
                        case 'TRENDING':
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TrendingPlantsScreen()),
                          );
                          break;
                        case 'RARE':
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RarePlantsScreen()),
                          );
                          break;
                        case 'HERBS':
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HerbsPlantsScreen()),
                          );
                          break;
                        case 'FLOWERING':
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FloweringPlantsScreen()),
                          );
                          break;
                        case 'EASY CARE':
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EasyCarePlantsScreen()),
                          );
                          break;
                        default:
                          break;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(filter),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Featured Plants',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          // Grid view for plants
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Display two images side by side
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1, // Aspect ratio to make images fit inside grid cells
            ),
            itemCount: plantList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlantDetailScreen(plantName: plantList[index]['name']!),
                    ),
                  );
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Image container with full screen usage inside grid cell
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            plantList[index]['image']!,
                            fit: BoxFit.cover, // Ensure the image fills the space
                            width: double.infinity, // Make the image fill the container
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        plantList[index]['name']!,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
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

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Settings Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
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
class AllPlantsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Plants")),
      body: Center(
        child: Text(
          "All Plants",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class IndoorPlantsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Indoor Plants")),
      body: Center(
        child: Text(
          "Indoor Plants",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class OutdoorPlantsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Outdoor Plants")),
      body: Center(
        child: Text(
          "Outdoor Plants",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class SeasonalPlantsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Seasonal Plants")),
      body: Center(
        child: Text(
          "Seasonal Plants",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class TrendingPlantsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trending Plants")),
      body: Center(
        child: Text(
          "Trending Plants",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class RarePlantsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rare Plants")),
      body: Center(
        child: Text(
          "Rare Plants",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class HerbsPlantsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Herbs Plants")),
      body: Center(
        child: Text(
          "Herbs Plants",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class FloweringPlantsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flowering Plants")),
      body: Center(
        child: Text(
          "Flowering Plants",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class EasyCarePlantsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Easy Care Plants")),
    body: Center(
    child: Text(
          "Easy Care Plants",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
