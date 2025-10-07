import 'package:flutter/material.dart';
import 'package:flutter_application/pages/home_page.dart';
import 'package:flutter_application/pages/maps_page.dart';
import 'package:flutter_application/pages/login_page.dart';
import 'package:flutter_application/pages/profile_page.dart';
import 'package:flutter_application/pages/notification_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.cyan),

      initialRoute: '/loginpage',

      routes: {
        '/loginpage': (context) => const LoginPage(),
        '/home_page': (context) => const HomePage(),
        '/mapspage': (context) => const MapsPage(),
        '/profilepage': (context) => const ProfilePage(),
        '/notificationpage': (context) => const NotificationPage(),
      },
    );
  }
}
