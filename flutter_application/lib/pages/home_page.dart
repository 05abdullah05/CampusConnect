import 'package:flutter/material.dart';
import 'package:flutter_application/pages/maps_page.dart';
import 'profile_page.dart';
import 'notification_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controls which tab is selected in BottomNavigationBar
  int _selectedIndex = 0;

  final Color darkBlue = const Color(0xFF001F3F);

  @override
  Widget build(BuildContext context) {
    // UserId is passed once and reused across (Profile, Notifications)
    final String? userId =ModalRoute.of(context)?.settings.arguments as String?;

    final homePage = SingleChildScrollView(
      // ScrollView prevents overflow on smaller screens
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),

          Center(
            child: Text(
              "Welcome to Campus Connect",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: darkBlue,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 20),

        
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/LIU.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
          ),

          const SizedBox(height: 45),

          // Recent Activity Feed
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent activity feed",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Color.fromARGB(255, 0, 217, 255),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Horizontal list of recent users (placeholder data)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: List.generate(4, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/prof1.jpg'),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "User${index + 1}",
                        style: TextStyle(
                          color: darkBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 40),

          // Map Preview
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "View Campus Map",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Color.fromARGB(255, 0, 217, 255),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Tapping image switches tab instead of pushing a new route
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = 1; // Navigate to Maps tab
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/map.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
            ),
          ),

          // Bottom padding so content doesn't collide with navigation bar
          const SizedBox(height: 90),
        ],
      ),
    );

    // Pages are kept in memory and switched using index (efficient tab navigation)
    final List<Widget> pages = <Widget>[
      homePage,
      const MapsPage(),
      NotificationPage(userId: userId ?? ''),
      ProfilePage(userId: userId ?? ''),
    ];

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: darkBlue),
      ),

      // Body updates based on selected bottom navigation index
      body: pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() => _selectedIndex = index); // Triggers UI rebuild
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notifications",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
