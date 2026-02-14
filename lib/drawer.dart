import 'package:bookstore/Admin/Home.dart';
import 'package:bookstore/cartlist.dart';
import 'package:bookstore/demo.dart';
import 'package:bookstore/home.dart';
import 'package:bookstore/credentials/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Mydrawer extends StatelessWidget {
  final User? user;

  const Mydrawer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    print("User: ${user?.displayName}, ${user?.email}"); // Debugging line

    return Drawer(
      child: Container(
        color: const Color.fromARGB(222, 244, 244, 244), // Background color of the drawer
        child: Column(
          children: [
            // Drawer header with custom design
            Container(
              color:const Color.fromARGB(255, 2, 73, 207), // Background color of the header
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20), // Adjusted padding for better alignment
              child: Column(
                children: [
                  // Container for the white border around the CircleAvatar
                  Container(
                    padding: const EdgeInsets.all(1.5), // Padding to create a white border
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white, 
                      // Border color (white)
                    ),
                    child: CircleAvatar(
                      radius: 50, // Outer radius of the avatar (size with border)
                      backgroundColor: Colors.transparent,
                      backgroundImage: user?.photoURL != null
                          ? NetworkImage(user!.photoURL!) // Load image from URL
                          : const AssetImage('assets/images/profile.png') as ImageProvider, // Fallback to local asset
                    ),
                  ),
                  const SizedBox(height: 10), // Space between image and text
                  
                  // Use a Row to align "Welcome" and the user name properly
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Centers the text within the row
                    children: [
                      const Text(
                        "Welcome, ", // Fixed part of the greeting
                        style: TextStyle(
                          color: Colors.white,
                          
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        user?.displayName ?? "user", // The dynamic part of the greeting
                        style: const TextStyle(
                          color: Colors.white,
                          
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Top items in the drawer
            Expanded(
              child: ListView(
                children: [
                  
                  // Dashboard ListTile
                  ListTile(
                    leading: const Icon(Icons.dashboard, color: Colors.black), // Dashboard icon
                    title: const Text("Dashboard"),
                    onTap: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => const AdminHomeScreen()));
                    },
                  ),
                  // Settings ListTile
                  ListTile(
                    leading: const Icon(Icons.settings, color: Colors.black), // Settings icon
                    title: const Text("Settings"),
                    onTap: () {
                      // Add your navigation or functionality here for Settings
                    },
                  ),
                  // Cart ListTile
                  ListTile(
                    leading: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
                    title: const Text("Cart"),
                    onTap: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => const Mycartlist()));
                    },
                  ),
                ],
              ),
            ),
            // Logout at the bottom
            ListTile(
              leading: const Icon(Icons.logout, color: Color.fromARGB(255,222, 4, 2)), // Logout icon with red color
              title: const Text(
                "Logout",
                style: TextStyle(color: Color.fromARGB(255,222, 4, 2)), // Red color for Logout text
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => const Mylogin()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
