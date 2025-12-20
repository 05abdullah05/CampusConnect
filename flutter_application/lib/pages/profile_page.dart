import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  const ProfilePage({super.key, required this.userId});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Color accent =  const Color.fromRGBO(0, 188, 212, 1);

  @override
  Widget build(BuildContext context) {
    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId);

    return StreamBuilder<DocumentSnapshot>(
      stream: userDoc.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final username = data['username'] ?? "Unknown";
        final password = data['password'] ?? "";

        return Scaffold(
          backgroundColor: Colors.white,

          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Text(
              username,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            actions: [
              PopupMenuButton<String>(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: accent, width: 2), 
                ),
                icon: const Icon(Icons.menu, color: Colors.black),
                itemBuilder: (context) => [
                  const PopupMenuItem(value: "opt1", child: Text("Option 1")),
                  const PopupMenuItem(value: "opt2", child: Text("Option 2")),
                  const PopupMenuItem(value: "opt3", child: Text("Option 3")),
                ],
              ),
            ],
          ),

          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 40),

                // Steps + Calories (HORIZONTAL)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Steps",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _infoCard("1234"),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          "Calories Burned",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _infoCard("123 kcal"),
                      ],
                    ),
                  ],
                ),

                const Spacer(),

                // Buttons (EDIT PROFILE + LOGOUT)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 150,
                      child: _mainButton(
                        text: "Edit Profile",
                        color: accent,
                        textColor: Colors.white,
                        onPressed: () {
                          _openEditDialog(context, userDoc, username, password);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: _mainButton(
                        text: "Logout",
                        color: Colors.red,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/loginpage');
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  // INFO BOX
  Widget _infoCard(String value) {
    return Container(
      width: 160,
      height: 110,
      decoration: BoxDecoration(
        color: accent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono',
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    );
  }

  // MAIN BUTTON
  Widget _mainButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 220,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // EDIT PROFILE POPUP
  void _openEditDialog(
    BuildContext context,
    DocumentReference userDoc,
    String currentUsername,
    String currentPassword,
  ) {
    final usernameCtrl = TextEditingController(text: currentUsername);
    final oldPassCtrl = TextEditingController();
    final newPassCtrl = TextEditingController();

    String? usernameError;
    String? oldPasswordError;
    String? newPasswordError;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Edit Profile"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // USERNAME
                  TextField(
                    controller: usernameCtrl,
                    decoration: InputDecoration(
                      labelText: "Username",
                      errorText: usernameError,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // OLD PASSWORD
                  TextField(
                    controller: oldPassCtrl,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText:
                          "Old password (required for changing password)",
                      errorText: oldPasswordError,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // NEW PASSWORD
                  TextField(
                    controller: newPassCtrl,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "New password",
                      errorText: newPasswordError,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () => Navigator.pop(context),
                ),

                TextButton(
                  child: const Text("Save"),
                  onPressed: () async {
                    final newUsername = usernameCtrl.text.trim();
                    final oldPass = oldPassCtrl.text.trim();
                    final newPass = newPassCtrl.text.trim();

                    usernameError = null;
                    oldPasswordError = null;
                    newPasswordError = null;

                    // Username rules: 5 chars + at least 1 number
                    if (!RegExp(
                      r'^(?=.*\d)[A-Za-z0-9]{5,}$',
                    ).hasMatch(newUsername)) {
                      usernameError =
                          "Min 5 characters, letters & numbers only.";
                    }

                    // If new password is entered, validate rules
                    if (newPass.isNotEmpty) {
                      if (oldPass != currentPassword) {
                        oldPasswordError = "Old password doesn't match.";
                      }
                      if (!RegExp(
                        r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%^&*()_+]).{8,}$',
                      ).hasMatch(newPass)) {
                        newPasswordError =
                            "8 chars, 1 uppercase, 1 number, 1 symbol.";
                      }
                    }

                    // If validation fails, update UI
                    if (usernameError != null ||
                        oldPasswordError != null ||
                        newPasswordError != null) {
                      setState(() {});
                      return;
                    }

                    // Build update map
                    Map<String, dynamic> updateData = {'username': newUsername};

                    // If user changed password, include new password
                    if (newPass.isNotEmpty) {
                      updateData['password'] = newPass;
                    }

                    await userDoc.update(updateData);

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Changes saved!"),
                        backgroundColor: const Color(0xFF1BFFD1),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
