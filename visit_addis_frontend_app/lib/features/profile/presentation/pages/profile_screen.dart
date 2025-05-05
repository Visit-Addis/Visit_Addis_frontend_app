import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static const _tokenKey = 'auth_token';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}

class FavoriteItem {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final double averageRating;
  final String type;

  FavoriteItem({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.averageRating,
    required this.type,
  });

  factory FavoriteItem.fromJson(Map<String, dynamic> json, String type) {
    String imageUrl = '';
    if (json['images'] != null && json['images'].isNotEmpty) {
      imageUrl = json['images'][0]['url'];
    }

    return FavoriteItem(
      id: json['id'],
      name: json['name'],
      category: json['category'] ?? '',
      imageUrl: imageUrl,
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      type: type,
    );
  }
}

class ImagePickerService {
  static Future<File?> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile != null ? File(pickedFile.path) : null;
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Color greenColor = Colors.green;
  File? _profileImage;
  String? _profileImageUrl;
  String userName = '';
  String email = '';
  List<FavoriteItem> favorites = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    final token = await TokenManager.getToken();
    if (token == null) return;

    final response = await http.get(
      Uri.parse('https://visit-addis.onrender.com/api/v1/profile'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        userName = data['userName'] ?? '';
        email = data['email'] ?? '';
        _profileImageUrl = data['images'] != null && data['images'].isNotEmpty
            ? data['images'][0]['url']
            : null;
      });

      // Fetch favorites
      List<FavoriteItem> fetchedFavorites = [];
      for (String type in ['attractions', 'events', 'restaurants']) {
        List ids = data['favorite'][type];
        for (String id in ids) {
          final item = await _fetchFavoriteItem(type, id, token);
          if (item != null) {
            fetchedFavorites.add(item);
          }
        }
      }

      setState(() {
        favorites = fetchedFavorites;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Failed to load profile data. Status: ${response.statusCode}')),
      );
    }
  }

  Future<FavoriteItem?> _fetchFavoriteItem(
      String type, String id, String token) async {
    final response = await http.get(
      Uri.parse('https://visit-addis.onrender.com/api/v1/$type/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return FavoriteItem.fromJson(data, type);
    } else {
      return null;
    }
  }

  void _logout() async {
    await TokenManager.clearToken();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Logged out')));
  }

  void _pickProfileImage() async {
    final image = await ImagePickerService.pickImageFromGallery();
    if (image != null) {
      setState(() {
        _profileImage = image;
        print(_profileImage);
        _profileImageUrl = null;
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: greenColor)),
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
          const SizedBox(height: 20),
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!) as ImageProvider<Object>?
                    : (_profileImageUrl != null
                        ? NetworkImage(_profileImageUrl!)
                            as ImageProvider<Object>?
                        : null), // Default to no image
                child: (_profileImage == null && _profileImageUrl == null)
                    ? Icon(Icons.person, size: 50, color: greenColor)
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _pickProfileImage,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: greenColor,
                    child: const Icon(Icons.camera_alt,
                        size: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(userName,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(height: 5),
          Text(email, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          TabBar(
            controller: _tabController,
            indicatorColor: greenColor,
            labelColor: greenColor,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: 'Favorites'),
              Tab(text: 'Edit Profile'),
              Tab(text: 'App Settings'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                FavoritesTab(favorites: favorites, greenColor: greenColor),
                EditProfileScreen(greenColor: greenColor),
                AppSettingsScreen(greenColor: greenColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FavoritesTab extends StatelessWidget {
  final List<FavoriteItem> favorites;
  final Color greenColor;

  const FavoritesTab(
      {Key? key, required this.favorites, required this.greenColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return const Center(child: Text('No favorites added.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final item = favorites[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: item.imageUrl.isNotEmpty
                ? Image.network(item.imageUrl,
                    width: 50, height: 50, fit: BoxFit.cover)
                : Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.image_outlined, color: Colors.grey),
                  ),
            title: Text(item.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(item.category, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, color: greenColor, size: 16),
                    const SizedBox(width: 4),
                    Text('${item.averageRating} (${item.type})',
                        style: TextStyle(color: greenColor)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AppSettingsScreen extends StatefulWidget {
  final Color greenColor;

  const AppSettingsScreen({Key? key, required this.greenColor})
      : super(key: key);

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('themeMode') ?? 'system';
    setState(() {
      _themeMode = ThemeMode.values.byName(themeString);
    });
  }

  Future<void> _saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', mode.name);
  }

  void _setTheme(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
    _saveThemeMode(mode);
    // Notify the app to rebuild with the new theme
    MyApp.of(context)?.changeTheme(mode);
  }

  @override
  Widget build(BuildContext context) {
    final greenColor = widget.greenColor;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ListTile(
          leading: Icon(Icons.notifications, color: greenColor),
          title: const Text('Notifications'),
          trailing: Switch(value: true, onChanged: (val) {}),
        ),
        const Divider(),
        ListTile(
          leading: Icon(Icons.language, color: greenColor),
          title: const Text('Language'),
          trailing: const Text('English'),
          onTap: () {
            // Implement language picker
          },
        ),
        const Divider(),
        ListTile(
          leading: Icon(Icons.color_lens, color: greenColor),
          title: const Text('Theme'),
          trailing: DropdownButton<ThemeMode>(
            value: _themeMode,
            items: const [
              DropdownMenuItem(
                value: ThemeMode.system,
                child: Text('System'),
              ),
              DropdownMenuItem(
                value: ThemeMode.light,
                child: Text('Light'),
              ),
              DropdownMenuItem(
                value: ThemeMode.dark,
                child: Text('Dark'),
              ),
            ],
            onChanged: (mode) {
              if (mode != null) {
                _setTheme(mode);
              }
            },
          ),
        ),
      ],
    );
  }
}

// Create a way to access and change the theme
class MyApp extends StatefulWidget {
  final Widget home;

  const MyApp({Key? key, required this.home}) : super(key: key);

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('themeMode') ?? 'system';
    setState(() {
      _themeMode = ThemeMode.values.byName(themeString);
    });
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visit Addis',
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black87, // Dark app bar color
        ),
        scaffoldBackgroundColor:
            Colors.black, // Dark background for the scaffold
        cardColor: Colors.grey.shade900, // Dark card color
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      themeMode: _themeMode,
      home: widget.home,
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  final Color greenColor;

  const EditProfileScreen({super.key, required this.greenColor});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  File? _selectedImage;
  bool _isLoading = false;

  Future<void> _pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProfileData(); // Fetch and set the old email and name
  }

  Future<void> _loadProfileData() async {
    final token = await SharedPreferences.getInstance()
        .then((prefs) => prefs.getString('auth_token'));

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Auth token not found. Please log in again.')),
      );
      return;
    }

    final response = await http.get(
      Uri.parse('https://visit-addis.onrender.com/api/v1/profile'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _nameController.text = data['userName'] ?? ''; // Set the old name
        _emailController.text = data['email'] ?? ''; // Set the old email
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Failed to load profile data. Status: ${response.statusCode}')),
      );
    }
  }

  Future<void> _updateProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Auth token not found. Please log in again.')),
      );
      return;
    }

    final uri = Uri.parse('https://visit-addis.onrender.com/api/v1/profile');
    final request = http.MultipartRequest('PUT', uri)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['userName'] = _nameController.text
      ..fields['email'] = _emailController.text;

    if (_selectedImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        _selectedImage!.path,
        filename: p.basename(_selectedImage!.path),
      ));
    }

    setState(() => _isLoading = true);
    final response = await request.send();
    setState(() => _isLoading = false);

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Failed to update profile. Status: ${response.statusCode}')),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final greenColor = widget.greenColor;

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Edit Profile'),
      //   backgroundColor: greenColor,
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImageFromGallery,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : null,
                  child: _selectedImage == null
                      ? const Icon(Icons.camera_alt,
                          size: 40, color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _updateProfile,
                style: ElevatedButton.styleFrom(backgroundColor: greenColor),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
