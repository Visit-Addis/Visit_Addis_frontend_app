import 'package:flutter/material.dart';
// import 'attractions_provider.dart';

class AttractionList extends StatefulWidget {
  const AttractionList({super.key});

  @override
  State<AttractionList> createState() => _AttractionListState();
}

class _AttractionListState extends State<AttractionList> {
  List<Map<String, dynamic>> _attractions = [
    {
      'id': '1',
      'image': 'images/entoto.jpg',
      'description':
          'Entoto Park is one of the most attractive tourist destinations in Addis Ababa, Ethiopia. Click here to explore all that Entoto Park has to offer!',
      'name': 'Entoto Park',
      'rating': 3.0,
      'category': 'Park',
      'isFavorite': false,
    },
    {
      'id': '2',
      'image': 'images/artkillo.jpg',
      'description':
          '4 Killo is a good place to refresh and see historical records from different eras in Ethiopia\'s ancient history.',
      'name': '4 Killo Lion Compound',
      'rating': 4.1,
      'category': 'Historical',
      'isFavorite': false,
    },
    {
      'id': '3',
      'image': 'images/andinet.jpg',
      'description':
          'Andinet park is one of Ethiopia\'s popular parks that attracts many tourists and has been rated 4.9 out of 5.',
      'name': 'Unity Park/Andinet Park',
      'rating': 4.9,
      'category': 'Park',
      'isFavorite': false,
    },
    {
      'id': '4',
      'image': 'images/waterpark.jpg',
      'description':
          'The beautiful water park found at the heart of Piassa in Addis Ababa.',
      'name': 'Water Park',
      'rating': 4.0,
      'category': 'Park',
      'isFavorite': false,
    },
    {
      'id': '5',
      'image': 'images/hotel5.jpg',
      'name': 'Blue Sky Hotel',
      'description':
          'Blue Sky Hotel is one of the 5-star hotels in Ethiopia and it\'s awesome, you should check it out.',
      'rating': 3.0,
      'category': 'Hotel',
      'isFavorite': false,
    },
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     Provider.of<AttractionsProvider>(context, listen: false)
  //         .fetchAttractions();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Attractions",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
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
                          // onChanged: (value) {
                          //   provider.filterAttractions(value);
                          // },
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
                        icon: const Icon(
                          Icons.filter_alt_outlined,
                          color: Colors.greenAccent,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Filter feature coming soon")),
                          );
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
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _attractions.length,
                itemBuilder: (context, index) {
                  final attract = _attractions[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(
                      //   context,
                      //   AppRoutes.attractionDetails,
                      //   arguments: attract['id'],
                      // );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            attract['image'],
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${attract['name']}: A Must-Visit Destination in Addis Ababa, Ethiopia",
                              style: const TextStyle(
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
                                          255, 94, 231, 179),
                                      width: 2,
                                    ),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      // provider.toggleFavorite(attract['id']);
                                    },
                                    icon: Icon(
                                      attract['isFavorite']
                                          ? Icons.favorite
                                          : Icons.favorite_border_outlined,
                                      color: const Color.fromARGB(
                                          255, 93, 241, 185),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text("Rating: "),
                                for (int i = 0; i < 5; i++)
                                  Icon(
                                    i < attract['rating'].toInt()
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: i < attract['rating'].toInt()
                                        ? Colors.yellow
                                        : Colors.black,
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
            ],
          ),
        ));
  }
}

Widget _buildFilterButton(String category) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 94, 235, 167),
        minimumSize: const Size(100, 40),
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
      onPressed: () {
        // provider.setFilterCategory(category == 'All' ? null : category);
      },
      child: Text(
        category,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
      ),
    ),
  );
}
