import 'package:bookstore/bottomnavbar.dart';
import 'package:bookstore/carousel.dart';
import 'package:bookstore/cartlist.dart';
import 'package:bookstore/categories.dart';
import 'package:bookstore/drawer.dart';
import 'package:bookstore/productcard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bookstore/profile.dart';





class Myhome extends StatefulWidget {
  const Myhome({super.key});

  @override
  _MyhomeState createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    FirebaseAuth.instance.authStateChanges().listen((User? newUser) {
      setState(() {
        user = newUser;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        elevation: 0, // Remove shadow
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0), // Add uniform space from the top
          child: Row(
            children: [
              // Search Bar
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(239, 238, 233, 233), // Light grey background for the search bar
                    borderRadius: BorderRadius.circular(25), // Rounded corners
                  ),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Icon(Icons.search, color: Colors.black), // Search icon
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search product',
                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Cart Icon
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined, color: Colors.grey),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Mycartlist()));
                  },
                ),
              ),

              // Notification Icon
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.person_2_rounded, color: Colors.grey),
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Myprofile(user: user,)));
                      },
                    ),
                    // Badge on the notification icon
                   
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Mycarousel(),
            const SizedBox(height: 30),
            Mycategories(user: user),
            const SizedBox(height: 30),
            const MyProductCard(),
          ],
        ),
      ),
      drawer: Mydrawer(user: user),
      bottomNavigationBar: const Mybottomnavbar(),
    );
  }
}
