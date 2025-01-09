import 'package:flutter/material.dart';

class DashBoardScreen extends StatelessWidget {
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
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search plants',
                prefixIcon: Icon(Icons.search),
                suffixIcon: Icon(Icons.camera_alt),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),

            SizedBox(height: 16),

            // Filter buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilterButton(label: 'ALL', isSelected: true),
                FilterButton(label: 'INDOOR', isSelected: false),
                FilterButton(label: 'OUTDOOR', isSelected: false),
              ],
            ),

            SizedBox(height: 16),

            // Popular section
            Text(
              'POPULAR',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: PlantCard(
                    imageUrl: 'assets/images/augmentedreality.png',
                    title: 'Snake Plant',
                    type: 'INDOOR',
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: PlantCard(
                    imageUrl: 'https://via.placeholder.com/150',
                    title: 'Aloe Vera',
                    type: 'INDOOR',
                  ),
                ),
              ],
            ),

            SizedBox(height: 24),

            // Reminder Section
            Text(
              'UPCOMING REMINDERS',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),

            // Use Flexible to handle ListView in Column
            Flexible(
              child: ListView(
                children: [
                  ReminderTile(
                    icon: Icons.water_drop,
                    title: 'Water Snake Plant',
                    subtitle: 'Tomorrow at 9:00 AM',
                  ),
                  ReminderTile(
                    icon: Icons.grass,
                    title: 'Fertilize Aloe Vera',
                    subtitle: 'In 3 days',
                  ),
                  ReminderTile(
                    icon: Icons.sunny,
                    title: 'Move Cactus to sunlight',
                    subtitle: 'Today at 4:00 PM',
                  ),
                ],
              ),
            ),

            // Action buttons
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ActionButton(icon: Icons.add, label: 'Add Plant'),
                ActionButton(icon: Icons.qr_code_scanner, label: 'Scan Plant'),
                ActionButton(icon: Icons.show_chart, label: 'Track Growth'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Filter Button Widget
class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  FilterButton({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: isSelected ? Colors.green : Colors.grey[200],
        onPrimary: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(label),
    );
  }
}

// Plant Card Widget
class PlantCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String type;

  PlantCard({required this.imageUrl, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.network(
              imageUrl,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: TextStyle(color: Colors.green, fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Reminder Tile Widget
class ReminderTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  ReminderTile({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.edit, color: Colors.grey),
      onTap: () {
        // Add functionality to edit or view the reminder
      },
    );
  }
}

// Action Button Widget
class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  ActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.green,
          child: Icon(icon, color: Colors.white),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
