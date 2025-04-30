import 'package:flutter/material.dart';
import 'package:visit_addis_frontend_app/features/hotels/presentation/pages/hotel_detail.dart';

class HotelList extends StatefulWidget {
  const HotelList({super.key});

  @override
  State<HotelList> createState() => _HotelListState();
}

class _HotelListState extends State<HotelList> {
  final ScrollController controller = ScrollController();

  List<dynamic> hotels = [
    {
      "image": 'images/hotel1.jpg',
      "name": "Sky light hotel",
      "description":
          "Sky light hotel is one of the 5 stars hotel in Ethiopia and its awesome you should check it out.",
      "rating": 5,
    },
    {
      "image": 'images/hotel2.jpg',
      "name": "Blue sky hotel",
      "description":
          "Blue sky hotel is one of the 5 stars hotel in Ethiopia and its awesome you should check it out.",
      "rating": 4,
    },

    {
      "image": 'images/hotel3.jpg',
      "name": "Blue sky hotel",
      "description":
          "Blue sky hotel is one of the 5 stars hotel in Ethiopia and its awesome you should check it out.",
      "rating": 5,
    },

    {
      "image": 'images/hotel4.jpg',
      "name": "Blue sky hotel",
      "description":
          "Blue sky hotel is one of the 5 stars hotel in Ethiopia and its awesome you should check it out.",
      "rating": 4,
    },

    {
      "image": 'images/hotel5.jpg',
      "name": "Blue sky hotel",
      "description":
          "Blue sky hotel is one of the 5 stars hotel in Ethiopia and its awesome you should check it out.",
      "rating": 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hotels",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                        decoration: InputDecoration(
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
                        icon: Icon(Icons.filter_alt),
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HotelDetail(),
                          ),
                        );
                      },
                      child: Text(
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
                      onPressed: () {},
                      child: Text(
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
                      child: Text(
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
                      child: Text(
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
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        ), // Adjust padding
                        minimumSize: MaterialStateProperty.all(
                          Size(80, 30),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
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
                physics: NeverScrollableScrollPhysics(),
                itemCount: hotels.length,
                itemBuilder: (context, index) {
                  final hotel = hotels[index];
                  return Card(
                    margin: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(hotel['image']),
                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text(
                            hotel['name'],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text(
                            hotel["description"],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: Text(
                            "Rating: ${hotel["rating"]} ⭐",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
