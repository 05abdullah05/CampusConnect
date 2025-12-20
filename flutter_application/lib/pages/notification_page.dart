import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationPage extends StatefulWidget {
  final String userId;

  const NotificationPage({super.key, required this.userId});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final TextEditingController _searchController = TextEditingController();
  String searchText = "";
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      

      appBar: AppBar(
        title: const Text("Notifications", style: TextStyle(fontSize: 40,fontWeight:FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),

      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchText = value.trim(); // Live search as user types
                });
              },
              decoration: InputDecoration(
                hintText: "Search users...",
                prefixIcon: const Icon(Icons.search),

                // Default border (not focused)
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.cyan),
                ),

                // Border when TextField is focused (clicked)
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.cyan, width: 2),
                ),
              ),
            ),
          ),


          // Search Results
          SizedBox(
            height: 200,
            child: StreamBuilder<QuerySnapshot>(  
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .limit(20)
                  .snapshots(),

              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final users = snapshot.data!.docs.where((doc) {
                  final username = (doc['username'] ?? "")
                      .toString()
                      .toLowerCase();
                  return username.contains(searchText.toLowerCase());
                }).toList();

                if (searchText.isEmpty) {
                  return const Center(
                    child: Text("Users will be shown here as you type"),
                  );
                }

                if (users.isEmpty) {
                  return const Center(child: Text("No users found"));
                }

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.cyan,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(users[index]['username']),
                    );
                  },
                );
              },
            ),
          ),

          const Divider(thickness: 1),

          // Notifications List
          // Notifications are backend-driven and fetched when the app opens
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8), 
            child: Text(
              "Messages",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: widget.userId.isEmpty 
            
                ? const Center(child: Text("No messages"))
                
                : StreamBuilder<QuerySnapshot>(  // Listen to notifications for this user 
                    stream: FirebaseFirestore.instance
                    
                        .collection('notifications')  
                        .where('toUserId', isEqualTo: widget.userId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      print("NOTIFICATION PAGE USER ID: ${widget.userId}");
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Error loading notifications"),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text("No notifications yet"),
                        );
                      }

                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final data =
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;

                          return ListTile(
                            leading: const Icon(Icons.notifications),
                            title: Text(data['message'] ?? ""),
                            subtitle: Text(
                              data['timestamp'] != null
                                  ? data['timestamp']
                                        .toDate()
                                        .toString()
                                        .substring(0, 16)
                                  : "",
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
