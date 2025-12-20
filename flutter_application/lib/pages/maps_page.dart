import 'package:flutter/material.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  // Controls which list is currently shown:
    // true  shows Restaurants
    // false shows Study places
  bool showRestaurants = true;

  final Color darkBlue = const Color(0xFF001F3F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text("Campus Map", style: TextStyle(fontSize: 40,fontWeight:FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color.fromARGB(230, 0, 0, 0),
        automaticallyImplyLeading: false,
      ),

      body: Column(
        children: [
          // Locations section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Locations",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                  ),
                ),

                const SizedBox(height: 12),
                // Buttons row
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showRestaurants = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: showRestaurants
                              ? Colors.cyan
                              : Colors.grey.shade300,
                          foregroundColor: showRestaurants
                              ? Colors.white
                              : Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Restaurants"),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showRestaurants = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: !showRestaurants
                              ? Colors.cyan
                              : Colors.grey.shade300,
                          foregroundColor: !showRestaurants
                              ? Colors.white
                              : Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Study Places"),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Location list
                Column(
                  children: showRestaurants
                      ? _restaurantList()
                      : _studyPlacesList(),
                ),
              ],
            ),
          ),

          const Divider(thickness: 1),

          // Map section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Map",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: darkBlue,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/map.jpg', 
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // list of restaurant locations on campus
  List<Widget> _restaurantList() {
    return const [
      ListTile(
        leading: Icon(Icons.restaurant),
        title: Text("Kiosk Amigo – Kårallen"),
      ),
       ListTile(
        leading: Icon(Icons.restaurant),
        title: Text("Café Dallucci – Building A"),
      ),
      ListTile(
        leading: Icon(Icons.restaurant),
        title: Text("Restraunt – StudentHuset"),
      ),
      ListTile(
        leading: Icon(Icons.restaurant),
        title: Text("Café Moccado – Building C"),
      ),
      ListTile(
        leading: Icon(Icons.restaurant),
        title: Text("StudentCafé Baljan – Kårallen"),
      ),
    ];
  }

  // list of study places on campus
  List<Widget> _studyPlacesList() {
    return const [
      ListTile(
        leading: Icon(Icons.school),
        title: Text("Library – StudentHuset"),
      ),
      ListTile(
        leading: Icon(Icons.school),
        title: Text("KG32-Grouproom – Keyhuset-Floor 3"),
      ),
      ListTile(
        leading: Icon(Icons.school),
        title: Text("AG31-Grouproom – Building A-Floor 3"),
      ),
      ListTile(
        leading: Icon(Icons.school),
        title: Text("SH605-Grouproom – StudentHuset-Floor 6"),
      ),
            ListTile(
        leading: Icon(Icons.school),
        title: Text("Minoranten-Grouproom – Building B-Floor 3"),
      )
    ];
  }
}
