import 'package:flutter/material.dart';
import 'package:visit_addis_frontend_app/features/attraction/presentation/attraction_detail.dart';

class AttractionList extends StatefulWidget {
  const AttractionList({super.key});

  @override
  State<AttractionList> createState() => _AttractionListState();
}

class _AttractionListState extends State<AttractionList> {
  bool isFavorite = false;
  List<dynamic> attractions = [
    {
      "image": 'images/entoto.jpg',
      "description":
          "Entoto Park is one of the most attractive tourist destinations in Addis Ababa, Ethiopia. Click here to explore all that Entoto Park has to offer!",
      "name": "Entoto Park",
      "rating": 3,
    },
    {
      "image": 'images/artkillo.jpg',
      "description":
          "4 killo  is a good place to referesh and see historical records from different era in Ethiopia's ancient history",
      "name": "4 Killo Lion compound",
      "rating": 4.1,
    },

    {
      "image": 'images/andinet.jpg',
      "description":
          "Andinet park is one of Ethiopian popular park that attarcted many tourists and have been rated 4.9 out of 5.",
      "name": "Unity Park/ Andinet park",
      "rating": 4.9,
    },

    {
      "image": 'images/waterpark.jpg',
      "description":
          "The beautiful water park found at the heart of piasa in Addis Ababa",
      "name": "water park",
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
          "Attraction",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Discover places in Addis Ababa.",
                style: TextStyle(fontSize: 16),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.5),
                            spreadRadius: 4,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Search hotels",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 114, 224, 197),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.greenAccent,
                      ),
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
                children: [
                  _buildFilterButton('All'),
                  _buildFilterButton('Historical'),
                  _buildFilterButton('Museum'),
                  _buildFilterButton('Cafes'),
                  _buildFilterButton('International'),
                ],
              ),
            ),

            const SizedBox(height: 20),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: attractions.length,
              itemBuilder: (context, index) {
                final attract = attractions[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(attract['image']),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${attract['name']}: A Must-Visit Destination in Addis Ababa, Ethiopia",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                attract['description'],
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color.fromARGB(
                                    255,
                                    94,
                                    231,
                                    179,
                                  ),
                                  width: 2,
                                ),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isFavorite = !isFavorite;
                                  });
                                },
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite_border_outlined
                                      : Icons.favorite,
                                  color: const Color.fromARGB(
                                    255,
                                    93,
                                    241,
                                    185,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 13),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          spacing: 4,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Rating: "),
                            for (int i = 0; i < 5; i++) ...[
                              if (i < attract['rating'])
                                Icon(Icons.star, color: Colors.yellow)
                              else
                                Icon(
                                  Icons.star_border,
                                  color: const Color.fromARGB(255, 12, 12, 12),
                                ),
                            ],
                          ],
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
    );
  }

  Widget _buildFilterButton(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 94, 235, 167),
          minimumSize: const Size(100, 40),
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AttractionDetail()),
          );
        },
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
