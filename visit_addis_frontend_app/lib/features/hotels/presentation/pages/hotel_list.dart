import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visit_addis_frontend_app/features/hotels/presentation/pages/hotel_detail.dart';

import '../../data/models/hotels_model.dart';
import '../bloc/hotel_bloc.dart';

class HotelList extends StatefulWidget {
  const HotelList({Key? key}) : super(key: key);

  @override
  State<HotelList> createState() => _HotelListState();
}

class _HotelListState extends State<HotelList> {
  final ScrollController controller = ScrollController();
  String? _selectedCategory;
  String _searchText = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HotelCubit>().fetchHotels();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  final List<String> _categories = [
    'All',
    'Traditional',
    'Modern',
    'cafes',
    'International'
  ];

  List<Restaurant> _filterHotels(List<Restaurant> hotels) {
    List<Restaurant> filteredHotels = hotels;

    if (_selectedCategory != null && _selectedCategory != 'All') {
      filteredHotels = filteredHotels
          .where((hotel) =>
              hotel.location?.toLowerCase() == _selectedCategory!.toLowerCase())
          .toList();
    }

    if (_searchText.isNotEmpty) {
      filteredHotels = filteredHotels
          .where((hotel) =>
              hotel.name?.toLowerCase().contains(_searchText.toLowerCase()) ==
                  true ||
              hotel.description
                      ?.toLowerCase()
                      .contains(_searchText.toLowerCase()) ==
                  true ||
              hotel.location
                      ?.toLowerCase()
                      .contains(_searchText.toLowerCase()) ==
                  true)
          .toList();
    }

    return filteredHotels;
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = const Color(0xFF00A368);
    final Color secondaryGreen = const Color(0xFF80CBC4);
    final Color lightGreen = const Color(0xFFC8E6C9); // Even lighter green

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hotels",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryGreen,
      ),
      body: BlocBuilder<HotelCubit, HotelState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.error != null) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            final hotels = state.hotels;
            final filteredHotels = _filterHotels(hotels);

            return SingleChildScrollView(
                controller: controller,
                child: Column(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Find the best local foods and places in Addis.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Search hotels",
                          prefixIcon: Icon(Icons.search, color: primaryGreen),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 12.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Wrap(
                        spacing: 8.0, // Spacing between buttons
                        children: _categories.map((category) {
                          return FilterChip(
                            label: Text(category),
                            selected: _selectedCategory == category,
                            onSelected: (selected) {
                              setState(() {
                                _selectedCategory = selected ? category : null;
                              });
                            },
                            backgroundColor: lightGreen,
                            selectedColor: primaryGreen,
                            checkmarkColor: Colors.white,
                            labelStyle: TextStyle(
                              color: _selectedCategory == category
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(color: primaryGreen, width: 1.0),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (filteredHotels.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _selectedCategory == null && _searchText.isEmpty
                            ? "No hotels available yet."
                            : "No hotels found matching your criteria.",
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredHotels.length,
                      itemBuilder: (context, index) {
                        final hotel = filteredHotels[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HotelDetail(hotelId: hotel.id),
                              ),
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16.0,
                            ),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (hotel.images != null &&
                                    hotel.images!.isNotEmpty)
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    ),
                                    child: Image.network(
                                      hotel.images!.first.url,
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                else
                                  Container(
                                    width: double.infinity,
                                    height: 200,
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: Text('No Image Available'),
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        hotel.name ?? 'No Name',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        hotel.description ?? 'No Description',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'location : ${hotel.location}' ??
                                            'No location',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        "Rating: 4 ⭐",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                ]));
          }
        },
      ),
    );
  }
}
