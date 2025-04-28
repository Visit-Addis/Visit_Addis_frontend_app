import 'package:flutter/material.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 4; // Profile tab selected by default

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() {
    // Implement your logout logic here
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logged out')));
  }

  @override
  Widget build(BuildContext context) {
    Color greenColor = Colors.green;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: _logout,
            child: Text('Logout', style: TextStyle(color: greenColor)),
          ),
        ],
      ),
      body: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, size: 50, color: greenColor),
          ),
          SizedBox(height: 10),
          Text('John Doe', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          SizedBox(height: 5),
          Text('john.doe@example.com', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 20),
          TabBar(
            controller: _tabController,
            indicatorColor: greenColor,
            labelColor: greenColor,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Favorites'),
              Tab(text: 'Edit Profile'),
              Tab(text: 'App Settings'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                FavoritesTab(greenColor: greenColor),
                EditProfileScreen(greenColor: greenColor),
                AppSettingsScreen(greenColor: greenColor),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: greenColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: 'Discover'),
          BottomNavigationBarItem(icon: Icon(Icons.event_outlined), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class FavoritesTab extends StatelessWidget {
  final Color greenColor;

  const FavoritesTab({Key? key, required this.greenColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return SavedPlaceCard(greenColor: greenColor);
      },
    );
  }
}

class SavedPlaceCard extends StatelessWidget {
  final Color greenColor;

  const SavedPlaceCard({Key? key, required this.greenColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.image_outlined, color: Colors.grey),
        ),
        title: Text('Saved Place', style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text('Category', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.star, color: greenColor, size: 16),
                SizedBox(width: 4),
                Text('4.5 (120 reviews)', style: TextStyle(color: greenColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  final Color greenColor;

  const EditProfileScreen({Key? key, required this.greenColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Center(
          child: Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.person, size: 50, color: greenColor),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: greenColor,
                  child: Icon(Icons.camera_alt, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Center(child: Text('Change profile photo')),
        SizedBox(height: 20),
        buildTextField('Full Name', 'Enter your full name'),
        buildTextField('Email', 'Enter your email'),
        buildTextField('Phone Number', 'Enter your phone number'),
        buildTextField('Location', 'Enter your location'),
        buildTextField('Bio', 'Tell us about yourself', maxLines: 3),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: greenColor),
          child: Text('Save'),
        ),
        SizedBox(height: 10),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.red,
            side: BorderSide(color: Colors.red),
          ),
          child: Text('Delete Account'),
        ),
      ],
    );
  }

  Widget buildTextField(String label, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}

class AppSettingsScreen extends StatelessWidget {
  final Color greenColor;

  const AppSettingsScreen({Key? key, required this.greenColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SwitchListTile(
          title: Text('Enable Notifications'),
          activeColor: greenColor,
          value: true,
          onChanged: (value) {},
        ),
        SwitchListTile(
          title: Text('Dark Mode'),
          activeColor: greenColor,
          value: false,
          onChanged: (value) {},
        ),
        ListTile(
          title: Text('Privacy Policy'),
          trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          onTap: () {},
        ),
        ListTile(
          title: Text('Terms of Service'),
          trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          onTap: () {},
        ),
      ],
    );
  }
}
