import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final CollectionReference users = FirebaseFirestore.instance.collection(
    'users',
  );

  final Color darkBlue = const Color(0xFF001F3F);

  @override
  Widget build(BuildContext context) {
    final double fieldWidth = MediaQuery.of(context).size.width * 0.85;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // title: const Text("Login"),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        foregroundColor: darkBlue,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: fieldWidth,
                height: 120,
                child: Image.asset('assets/Logo.png', fit: BoxFit.contain),
              ),
              const SizedBox(height: 30),

              // Username field
              SizedBox(
                width: fieldWidth,
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Enter your username',
                    labelStyle: TextStyle(color: darkBlue),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.cyan,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Password field
              SizedBox(
                width: fieldWidth,
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Enter your password',
                    labelStyle: TextStyle(color: darkBlue),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.cyan,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Login button
              SizedBox(
                width: fieldWidth,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    final username = _usernameController.text.trim();

                    if (username.isNotEmpty) {
                      //Add user to Firestore and get the document reference
                      final docRef = await users.add({
                        'username': username,
                        'createdAt': FieldValue.serverTimestamp(),
                      });

                      _usernameController.clear();
                      _passwordController.clear();

                      // Pass the Firestore doc ID to home-page
                      Navigator.pushReplacementNamed(
                        context,
                        '/home_page',
                        arguments: docRef.id,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a username'),
                        ),
                      );
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    foregroundColor: darkBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
