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
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  final Color darkBlue = const Color(0xFF001F3F);

  // Error messages
  String? usernameError;
  String? passwordError;

  // Validation functions
  bool validateUsername(String username) {
    final RegExp usernameRegex =
        RegExp(r'^(?=.*[0-9])[A-Za-z0-9]{5,}$'); 
    return usernameRegex.hasMatch(username);
  }

  bool validatePassword(String password) {
    final RegExp passwordRegex = RegExp(
        r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%^&*]).{8,}$'); 
    return passwordRegex.hasMatch(password);
  }

  Future<void> _loginOrRegister() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    setState(() {
      usernameError = validateUsername(username)
          ? null
          : "Username must be 5+ chars, contain a number and no special symbols.";

      passwordError = validatePassword(password)
          ? null
          : "Password must be 8+ chars, include uppercase, number & symbol.";
    });

    // Stop login if there are errors
    if (usernameError != null || passwordError != null) return;

    // Check if user exists
    final existingUser =
        await users.where('username', isEqualTo: username).limit(1).get();

    if (existingUser.docs.isNotEmpty) {
      final userData =
          existingUser.docs.first.data() as Map<String, dynamic>;
      final storedPassword = userData['password'];

      if (storedPassword == password) {
        Navigator.pushReplacementNamed(
          context,
          '/home_page',
          arguments: existingUser.docs.first.id,
        );
      } else {
        setState(() {
          passwordError = "Incorrect password.";
        });
      }
    } else {
      // Create new user
      final newDoc = await users.add({
        'username': username,
        'password': password,
        'createdAt': FieldValue.serverTimestamp(),
      });

      Navigator.pushReplacementNamed(
        context,
        '/home_page',
        arguments: newDoc.id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double fieldWidth = MediaQuery.of(context).size.width * 0.85;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        foregroundColor: darkBlue,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: fieldWidth,
                height: 280,
                child: Image.asset('assets/Logo.png'),
              ),
              const SizedBox(height: 30),

              // Username FIELD
              SizedBox(
                width: fieldWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Enter your username',
                        labelStyle: TextStyle(color: darkBlue),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.cyan, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (_) {
                        setState(() {
                          usernameError = null;
                        });
                      },
                    ),
                    if (usernameError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6, left: 4),
                        child: Text(
                          usernameError!,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 13),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // Password FIELD
              SizedBox(
                width: fieldWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Enter your password',
                        labelStyle: TextStyle(color: darkBlue),
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.cyan, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (_) {
                        setState(() {
                          passwordError = null;
                        });
                      },
                    ),
                    if (passwordError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6, left: 4),
                        child: Text(
                          passwordError!,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 13),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Login Button
              SizedBox(
                width: fieldWidth,
                height: 50,
                child: ElevatedButton(
                  onPressed: _loginOrRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Login",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
