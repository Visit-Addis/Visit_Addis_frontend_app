import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visit_addis_frontend_app/features/attraction/presentation/attraction_list.dart';
import 'package:visit_addis_frontend_app/features/hotels/presentation/pages/hotel_detail.dart'; // Import HotelDetail

import '../bloc/hotel_bloc.dart'; // Import your HotelCubit and HotelState

class HotelList extends StatefulWidget {
  const HotelList({Key? key}) : super(key: key);

  @override
  State<HotelList> createState() => _HotelListState();
}

class _HotelListState extends State<HotelList> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<HotelCubit>().fetchHotels(); // Fetch hotels on init
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hotels",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<HotelCubit, HotelState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.error != null) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            final hotels = state.hotels;
            return SingleChildScrollView(
              controller: controller,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Find the best local foods and places in Addis.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Search hotels",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.filter_alt),
                            onPressed: () {
                              print('Filter button pressed');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      spacing: 4,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 94, 235, 167),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'All',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 94, 235, 167),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AttractionList(),
                              ),
                            );
                          },
                          child: const Text(
                            'Traditional',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 94, 235, 167),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Modern',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 94, 235, 167),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'cafes',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 94, 235, 167),
                            ),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                            ), // Adjust padding
                            minimumSize:
                                MaterialStateProperty.all(const Size(80, 30)),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'International',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: hotels.length,
                    itemBuilder: (context, index) {
                      final hotel = hotels[index];
                      return GestureDetector(
                        // Wrap the Card with GestureDetector
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HotelDetail(
                                  hotelId: hotel.id), // Pass the hotel ID
                            ),
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
                              // Display the image if available
                              if (hotel.images != null &&
                                  hotel.images!.isNotEmpty)
                                Image.network(
                                  hotel.images!.first
                                      .url, // Access the image URL directly
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                )
                              else
                                Container(
                                  width: double.infinity,
                                  height: 200,
                                  color: Colors.grey[300], // Placeholder color
                                  child: const Center(
                                    child: Text('No Image Available'),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.all(6),
                                child: Text(
                                  hotel.name ??
                                      'No Name', // Provide a default value
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(6),
                                child: Text(
                                  hotel.description ??
                                      'No Description', // Provide a default value
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(6),
                                child: Text(
                                  'location : ${hotel.location}' ??
                                      'No location',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              const Padding(
                                padding: EdgeInsets.all(6),
                                child: Text(
                                  "Rating: 4 ⭐",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                  ),
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
          }
        },
      ),
    );
  }
}
