import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/hotels_model.dart'; // Import your Hotel model
import '../bloc/hotel_bloc.dart'; // Import your HotelCubit

class HotelDetail extends StatefulWidget {
  final String hotelId; // hotelId is a String

  const HotelDetail({Key? key, required this.hotelId}) : super(key: key);

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> {
  Restaurant? _hotel; // State variable to hold the fetched hotel

  @override
  void initState() {
    super.initState();
    _fetchHotelDetails(); // Fetch hotel details when the widget is initialized
  }

  Future<void> _fetchHotelDetails() async {
    // Fetch hotel details using the hotelId
    try {
      final hotel = await context
          .read<HotelCubit>()
          .apiService
          .fetchHotelById(widget.hotelId);
      setState(() {
        _hotel = hotel; // Update the state with the fetched hotel
      });
    } catch (e) {
      // Handle error (e.g., display an error message)
      print('Error fetching hotel details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hotel == null) {
      // Display a loading indicator or an error message while fetching
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    bool isFavorite = false; // Manage favorite state
    List<String> foods = [
      "images/food1.jpg",
      "images/food2.jpg",
      "images/food3.jpg",
      "images/food4.jpg",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _hotel!.name ?? 'No Name', // Provide a default value if name is null
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  if (_hotel!.images != null && _hotel!.images!.isNotEmpty)
                    Image.network(
                      _hotel!.images!.first.url, // Access the image URL directly
                      fit: BoxFit.cover,
                      height: 250,
                      width: double.infinity,
                    )
                  else
                    Container(
                      height: 250,
                      width: double.infinity,
                      color: Colors.grey[300], // Placeholder color
                      child: const Center(
                        child: Text('No Image Available'),
                      ),
                    ),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4.0,
                            spreadRadius: 1.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.greenAccent,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 18,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.greenAccent,
                      ),
                      child: IconButton(
                        icon: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border_sharp,
                          size: 25,
                          color: isFavorite ? Colors.pinkAccent : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    right: 60,
                    top: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.greenAccent,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.download,
                          size: 20,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          print('Download clicked');
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                _hotel!.name ??
                    'No Name', // Provide a default value if name is null
                style:
                    const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.location_on),
                  Text(
                      " Location Address: ${_hotel!.location ?? 'No Location'}"), // Provide a default value if location is null
                ],
              ),
              const SizedBox(height: 10),
              // Row(
              //   children: [
              //     const Icon(Icons.star_border),
              //     // Text("${_hotel!.averageRating}, (120 reviews)"),
              //   ],
              // ),
              const SizedBox(height: 20),
              const Text("About",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(height: 20),
              Text(_hotel!.description ??
                  'No Description'), // Provide a default value if description is null
              const SizedBox(height: 20),
              Text(
                  "Foods in ${_hotel!.name ?? 'This Restaurant'}", // Provide a default value if name is null
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Container(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Card(
                        child: Image.asset(
                          foods[index],
                          width: 100,
                          height: 100,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              OutlinedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                      const BorderSide(color: Colors.black)),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero)),
                ),
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8,
                  children: [
                    Icon(Icons.call_outlined, color: Colors.black),
                    Text("Call Venue", style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                      const BorderSide(color: Colors.black)),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero)),
                ),
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.language, color: Colors.black),
                    Text("Visit Website",
                        style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
