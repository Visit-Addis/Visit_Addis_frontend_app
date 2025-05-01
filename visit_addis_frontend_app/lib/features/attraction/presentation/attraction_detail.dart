import 'package:flutter/material.dart';

class AttractionDetail extends StatefulWidget {
  const AttractionDetail({super.key});

  @override
  State<AttractionDetail> createState() => _AttractionDetailState();
}

class _AttractionDetailState extends State<AttractionDetail> {
  bool isFavorite = false;
  List<String> events = [
    "images/event1.jpg",
    "images/event2.jpg",
    "images/event3.jpg",
  ];

  List<dynamic> attraction = [
    {
      "image": 'images/waterpark.jpg',
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
    "images/andinet.jpg",
    "images/artkillo.jpg",
    "images/entoto.jpg",
    "images/hotel3.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${attraction[0]['name']} Hotel",
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
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
                    attraction[0]['image'],
                    fit: BoxFit.cover,
                    height: 250,
                    width: double.infinity,
                  ),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4.0,
                            spreadRadius: 1.0,
                            offset: const Offset(0, 2),
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
                attraction[0]['name'],
                style: const TextStyle(
                    fontSize: 23, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on),
                  const SizedBox(width: 5),
                  Text("Location Address: ${attraction[0]['location']}"),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.star_border),
                  const SizedBox(width: 5),
                  Text("${attraction[0]['rating']}, (120 reviews)"),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Events",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // FIXED: Replace ListView with Column since we're inside SingleChildScrollView
              Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.access_time, color: Colors.blue),
                    title: const Text(
                      "Hours",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: const Text(
                      "9:00 AM - 5:00 PM",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading:
                        const Icon(Icons.monetization_on, color: Colors.green),
                    title: const Text(
                      "Entry Fee",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: const Text("200 ETB",
                        style: TextStyle(fontSize: 14)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "About",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(attraction[0]['about']),
              const SizedBox(height: 20),
              const Text(
                "Photos in Sky light hotel",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Card(
                        child: Image.asset(
                          events[index],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      const BorderSide(color: Colors.black),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                  onPressed: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.call_outlined, color: Colors.black),
                      SizedBox(width: 8),
                      Text("Call Venue", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                      const BorderSide(color: Colors.black),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                  onPressed: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.language, color: Colors.black),
                      SizedBox(width: 8),
                      Text("Visit Website", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}