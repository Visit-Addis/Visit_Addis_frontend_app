import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/routes.dart';
import '../../attraction/data/models/attraction_models.dart'; // Import your Attraction model
import '../bloc/attraction_bloc.dart'; // Import your AttractionCubit

class AttractionList extends StatefulWidget {
  const AttractionList({super.key});

  @override
  State<AttractionList> createState() => _AttractionListState();
}

class _AttractionListState extends State<AttractionList> {
  String? _selectedCategory; // Track the selected category

  @override
  void initState() {
    super.initState();
    context.read<AttractionCubit>().fetchAttractions();
  }

  // Define the available categories - MATCH THESE TO YOUR BACKEND!
  final List<String> _categories = [
    'All',
    'historicals',
    'parks',
    'museum',
    'church',
    'Other'
  ];

  // Function to filter attractions based on the selected category
  List<Attraction> _filterAttractions(List<Attraction> attractions) {
    if (_selectedCategory == null || _selectedCategory == 'All') {
      return attractions;
    } else if (_selectedCategory == 'Other') {
      return attractions
          .where((attraction) =>
              attraction.category != 'historicals' &&
              attraction.category != 'parks' &&
              attraction.category != 'museum' &&
              attraction.category != 'church')
          .toList();
    } else {
      return attractions
          .where((attraction) =>
              attraction.category?.toLowerCase() ==
              _selectedCategory!.toLowerCase())
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryGreen =
        Color(0xFF00A368); // Define your primary green color
    final Color secondaryGreen = Color(0xFF80CBC4); // Define a lighter green

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Attractions",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryGreen, // Apply green to AppBar
      ),
      body: BlocBuilder<AttractionCubit, AttractionState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text(state.error!));
          }

          // Filter the attractions based on the selected category
          final filteredAttractions = _filterAttractions(state.attractions);

          return SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Discover places in Addis Ababa.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                // Category Filter Chips
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ChoiceChip(
                          label: Text(
                            category,
                            style: TextStyle(
                              color: _selectedCategory == category
                                  ? Colors.white // Selected text color
                                  : Colors.black87, // Unselected text color
                            ),
                          ),
                          selected: _selectedCategory == category,
                          onSelected: (selected) {
                            setState(() {
                              _selectedCategory = selected ? category : null;
                            });
                          },
                          backgroundColor:
                              secondaryGreen, //Unselected chip color
                          selectedColor: primaryGreen, // Selected chip color
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20.0), // Rounded corners
                          ),
                          side: BorderSide(
                            color: primaryGreen, // Border color
                            width: 1.0,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (filteredAttractions.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _selectedCategory == null || _selectedCategory == 'All'
                          ? "No attractions available yet."
                          : "No attractions found in the $_selectedCategory category.",
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredAttractions.length,
                    itemBuilder: (context, index) {
                      final attract = filteredAttractions[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.attractionsDetails,
                            arguments: attract.id,
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (attract.imageUrl != null)
                                Image.network(
                                  attract.imageUrl!,
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: double.infinity,
                                ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${attract.name}: A Must-Visit Destination in Addis Ababa, Ethiopia",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(attract.description),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    const Text("Ticket Price: "),
                                    Text("ETB ${attract.ticketPrice}"),
                                  ],
                                ),
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
        },
      ),
    );
  }
}
