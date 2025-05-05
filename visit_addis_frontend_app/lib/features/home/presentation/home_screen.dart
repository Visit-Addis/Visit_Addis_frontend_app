import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visit_addis_frontend_app/features/events/presentation/pages/event_list.dart';
import 'package:visit_addis_frontend_app/features/home/data/services/home_api_service.dart';

import '../../../features/hotels/presentation/pages/hotel_list.dart';
import '../../../features/profile/presentation/pages/profile_screen.dart'; // Correct import
import '../../attraction/presentation/attraction_list.dart';
import '../../auth/presentation/bloc/login_bloc.dart';
import '../../auth/presentation/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final fetchedUserName = await HomeApiService().fetchUserName();
    setState(() {
      userName =
          fetchedUserName ?? 'Guest'; // Fallback to 'Guest' if username is null
    });
  }

  int _currentIndex = 0;

  void _onTabTapped(int index) {
    final bool isProtectedRoute = index != 0;

    if (isProtectedRoute && !context.read<LoginBloc>().state.isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
      return;
    }

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = const Color(0xFF00A368); // Your primary green
    final Color lightGreen = const Color(0xFFC8E6C9); // Even lighter green

    final List<Widget> _children = [
      HomeContent(userName: userName), // Index 0 - Home
      const AttractionList(), // Index 1 - Discover
      const EventList(), // Index 2 - Events
      const HotelList(), // Index 3 - Hotels
      const ProfileScreen(), // Index 4 - Profile
    ];
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: primaryGreen, // Use primary green
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: "Discover",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_outlined),
            label: "Events",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hotel_outlined),
            label: "Hotels",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final String userName;
  const HomeContent({super.key, required this.userName});
  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = const Color(0xFF00A368); // Your primary green
    final Color lightGreen = const Color(0xFFC8E6C9); // Even lighter green
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent, // Make AppBar transparent
          elevation: 0, // Remove shadow
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primaryGreen.withOpacity(0.8),
                  lightGreen.withOpacity(0.6)
                ], // Gradient from primary to light green
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Visit Addis",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.notifications_none_outlined,
                    color: Colors.white),
                onPressed: () {
                  // Handle notification tap
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Greeting
                Text(
                  "Good Afternoon, $userName!",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text("Explore the beauty of Addis Ababa"),
                const SizedBox(height: 16),

                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: primaryGreen.withOpacity(0.5),
                              spreadRadius: 4,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Search attractions",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Featured Section
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Featured",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("See All",
                        style: TextStyle(color: Colors.greenAccent)),
                  ],
                ),
                const SizedBox(height: 12),

                FutureBuilder(
                  future: HomeApiService.fetchFeaturedAttractions(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                          child: Text("Failed to load featured attractions"));
                    } else {
                      final attractions = snapshot.data!;
                      return SizedBox(
                        height: 180,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: attractions.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final attraction = attractions[index];
                            return _buildFeaturedCard(
                              attraction.name,
                              attraction.category,
                              attraction.imageUrl,
                            );
                          },
                        ),
                      );
                    }
                  },
                ),

                // Explore Section
                const Text("Explore",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildExploreIcon(Icons.location_on_outlined, "Attractions",
                        () {
                      _navigateToScreen(context, const AttractionList());
                    }),
                    _buildExploreIcon(Icons.event_outlined, "Events", () {
                      _navigateToScreen(context, const EventList());
                    }),
                    _buildExploreIcon(Icons.hotel_outlined, "Hotels", () {
                      _navigateToScreen(context, const HotelList());
                    }),
                  ],
                ),
                const SizedBox(height: 24),

                // Popular Near You Section
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Popular Near You",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("See All",
                        style: TextStyle(color: Colors.greenAccent)),
                  ],
                ),
                const SizedBox(height: 12),

                FutureBuilder<List<Map<String, dynamic>>>(
                  future: HomeApiService().getPopularRestaurants(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final restaurants = snapshot.data!;
                      return SingleChildScrollView(
                        child: Column(
                          children: restaurants.map((restaurant) {
                            return _buildPopularCard(
                              name: restaurant['name'],
                              category: restaurant['category'],
                              distance: restaurant['location'],
                              imageUrl: restaurant['imageUrl'] ?? '',
                              rating: (restaurant['rating'] as num).toDouble(),
                            );
                          }).toList(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    if (!context.read<LoginBloc>().state.isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => screen),
      );
    }
  }

  static Widget _buildFeaturedCard(
      String title, String category, String? imageUrl) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(
            imageUrl ?? 'https://placehold.co/600x400/png',
          ),
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
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildExploreIcon(
      IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.greenAccent, size: 30),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }

  static Widget _buildPopularCard({
    required String name,
    required String category,
    required String distance,
    required double rating,
    required String imageUrl,
  }) {
    return Container(
      width: double
          .infinity, // Ensure the card takes up the full width of its parent
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: 600), // Add width constraints
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl.isNotEmpty
                    ? imageUrl
                    : 'https://placehold.co/600x400/png',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(name),
            subtitle: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        return Icon(
                          index < rating.floor()
                              ? Icons.star
                              : index < rating
                                  ? Icons.star_half
                                  : Icons.star_border,
                          color: Colors.amber,
                          size: 16,
                        );
                      }),
                      const SizedBox(width: 8),
                      const Icon(Icons.location_on_outlined,
                          color: Colors.grey, size: 16),
                      const SizedBox(width: 4),
                      Text(distance),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
