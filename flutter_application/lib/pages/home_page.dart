import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Keep track of which tab is selected in the bottom navigation bar
  int _selectedIndex = 0;

  // Placeholder pages for each tab
  final List<Widget> _pages = <Widget>[
    // Home tab
    const Center(
      child: Text(
        "Welcome to Campus Connect",
        style: TextStyle(
          fontSize: 22, 
          fontWeight: FontWeight.bold, 
        ),
        textAlign: TextAlign.center,
      ),
    ),
    // Map tab
    const Center(child: Text("Map Page Placeholder")),
    // Notifications tab
    const Center(child: Text("Notifications Placeholder")),
    // Profile tab
    const Center(child: Text("Profile Placeholder")),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update state to show selected page
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Main app bar
      appBar: AppBar(
        title: const Text("Campus Connect"),
        centerTitle: true, 
      ),

      // Body will change depending on which tab is selected
      body: _pages[_selectedIndex],

      // Bottom navigation bar with 4 icons
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,  // Makes all icons visible
        currentIndex: _selectedIndex,         // Highlight the selected icon
        selectedItemColor: Colors.cyan,     // Active icon color
        unselectedItemColor: Colors.grey,   // Inactive icon color
        onTap: _onItemTapped,                 // Call the function when tapped
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
