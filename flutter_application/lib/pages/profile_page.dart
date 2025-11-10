import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatelessWidget {
  final String? userId;
  const ProfilePage({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return const Center(
        child: Text(
          "No user information found",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    }

    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(userId);

    return StreamBuilder<DocumentSnapshot>(
      stream: userDoc.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text("User not found"));
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>?;
        final username = userData?['username'] ?? 'Unknown user';

        return Center(
          child: Text(
            "Logged in as $username",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        );
      },
    );
  }
}
