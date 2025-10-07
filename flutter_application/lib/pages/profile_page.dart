import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String? username;
  const ProfilePage({super.key, this.username});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        username != null
            ? "Logged in as $username"
            : "No user information found",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

