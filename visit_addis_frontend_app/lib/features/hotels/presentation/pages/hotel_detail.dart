import 'package:flutter/material.dart';

class HotelDetail extends StatefulWidget {
  const HotelDetail({super.key});

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> {
  bool isFavorite = false;
  List<dynamic> hotel = [
    {
      "image": 'images/hotel1.jpg',
      "name": "Sky light hotel",
      "description":
          "Sky light hotel is one of the 5 stars hotel in Ethiopia and its awesome you should check it out.",
      "rating": 5,
      "location": "Gerji mebrat hayl",
      "about":
          "Lorem ipsum refers to placeholder text often used in publishing and graphic design to demonstrate the visual style of a document, webpage, or typeface.",
    },
  ];
  List<String> foods = [
    "images/food1.jpg",
    "images/food2.jpg",
    "images/food3.jpg",
    "images/food4.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${hotel[0]['name']} Hotel",
          style: TextStyle(color: Colors.black),
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
                  Image.asset(
                    hotel[0]['image'],
                    fit: BoxFit.cover,
                    height: 250,
                    width: double.infinity,
                  ),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        boxShadow: [
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
                        icon: Icon(
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
                        icon: Icon(
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
                hotel[0]['name'],
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on),
                  Text(" Location Address: ${hotel[0]['location']}"),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.star_border),
                  Text("${hotel[0]['rating']}, (120 reviews)"),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "About",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 20),
              Text(hotel[0]['about']),
              const SizedBox(height: 20),
              Text(
                "Foods in ${hotel[0]['name']}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              Container(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 10),
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
                    BorderSide(color: Colors.black),
                  ),

                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                ),
                onPressed: () {},
                child: Row(
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
                    BorderSide(color: Colors.black),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.zero, // Set to zero for sharp corners
                    ),
                  ),
                ),

                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.language, color: Colors.black),
                    Text(
                      "Visit Website",
                      style: TextStyle(color: Colors.black),
                    ),
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
