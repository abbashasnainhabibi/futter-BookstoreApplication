import 'package:bookstore/Admin/Appbar.dart';
import 'package:bookstore/Admin/Appbar.dart';

import 'package:flutter/material.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(), // Use CustomAppBar here
      drawer: CustomDrawer(), // Pass the context here
      backgroundColor: Colors.white, // Set the background color to white
      body: const Center(
        child: Text(
          'Welcome to Admin Panel',
          style: TextStyle(color: Colors.black), // Ensure the text is visible
        ),
      ),
    );
  }
}
