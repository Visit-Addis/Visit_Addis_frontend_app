import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Color greenColor = Color(0xFF00A86B);

  HomeScreen({super.key}); // Custom green

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: greenColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: "Discover"),
          BottomNavigationBarItem(icon: Icon(Icons.event_outlined), label: "Events"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined), label: "Favorites"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Visit Addis",
                      style: TextStyle(
                        color: greenColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Icon(Icons.notifications_none_outlined),
                  ],
                ),
                SizedBox(height: 16),

                // Greeting
                Text(
                  "Good Afternoon, Alex!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text("Explore the beauty of Addis Ababa"),
                SizedBox(height: 16),

                // Search bar
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search for attractions, events, restaurants...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                SizedBox(height: 24),

                // Featured section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Featured", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("See All", style: TextStyle(color: greenColor)),
                  ],
                ),
                SizedBox(height: 12),
                SizedBox(
                  height: 180,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildFeaturedCard("National Museum", "Historical"),
                      SizedBox(width: 12),
                      _buildFeaturedCard("Holy Trinity Cathedral", "Religious"),
                    ],
                  ),
                ),
                SizedBox(height: 24),

                // Explore icons
                Text("Explore", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildExploreIcon(Icons.location_on_outlined, "Attractions"),
                    _buildExploreIcon(Icons.event_outlined, "Events"),
                    _buildExploreIcon(Icons.restaurant_menu_outlined, "Restaurants"),
                    _buildExploreIcon(Icons.favorite_border_outlined, "Favorites"),
                  ],
                ),
                SizedBox(height: 24),

                // Popular Near You section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Popular Near You", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("See All", style: TextStyle(color: greenColor)),
                  ],
                ),
                SizedBox(height: 12),
                _buildPopularCard("Tomoca Coffee", "Cafe", "1.2 km", 4.8),
                _buildPopularCard("Red Terror Martyrs Memorial", "Museum", "2.5 km", 4.6),
                _buildPopularCard("Addis Ababa Restaurant", "Traditional Food", "0.8 km", 4.7),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedCard(String title, String category) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage('https://placehold.co/600x400/png'), // Network placeholder
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.7), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(category, style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExploreIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.green, size: 30),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }

  Widget _buildPopularCard(String name, String category, String distance, double rating) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            'https://placehold.co/600x400/png', // Network placeholder
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(category),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                SizedBox(width: 4),
                Text(rating.toString()),
                SizedBox(width: 8),
                Icon(Icons.location_on_outlined, color: Colors.grey, size: 16),
                SizedBox(width: 4),
                Text(distance),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
