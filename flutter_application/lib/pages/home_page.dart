import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome to Campus Connect")),
      body: Center(
        child: ElevatedButton(
          child: const Text("Maps"),
          onPressed: () 
          {
            Navigator.pushNamed(context, '/mapspage');
          }, 
        ),
      ),
    );
  }
}

