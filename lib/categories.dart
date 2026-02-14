import 'package:bookstore/category_of_books/fiction.dart';
import 'package:bookstore/category_of_books/non-fiction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Mycategories extends StatelessWidget {
  final User? user;
  const Mycategories({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;
    // Calculate the width for each category item (divide screen width by 5 with padding)
    double itemWidth = (screenWidth - 68) / 5; // Adjust spacing here (70 = total spacing)

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Category 1
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Mycategoryfiction(user: user)));
            },
            child: Container(
              height: 60,
              width: itemWidth, // Dynamically calculated width
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 243, 239, 239),
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.book, color: Color.fromARGB(255, 222, 4, 2)),
                  Text("Fiction",
                      style: TextStyle(color: Colors.black, fontSize: 12)),
                ],
              ),
            ),
          ),
          // Category 2
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Mycategorynonfiction(user: user)));
            },
            child: Container(
              height: 60,
              width: itemWidth, // Dynamically calculated width
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 243, 239, 239),
                borderRadius: BorderRadius.circular(7),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.menu_book,
                      color: Color.fromARGB(255, 222, 4, 2)),
                  Text("Non-Fiction",
                      style: TextStyle(color: Colors.black, fontSize: 11)),
                ],
              ),
            ),
          ),
          // Category 3
          Container(
            height: 60,
            width: itemWidth, // Dynamically calculated width
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 243, 239, 239),
              borderRadius: BorderRadius.circular(7),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.science, color: Color.fromARGB(255, 222, 4, 2)),
                Text("Sci-Fiction",
                    style: TextStyle(color: Colors.black, fontSize: 11)),
              ],
            ),
          ),
          // Category 4
          Container(
            height: 60,
            width: itemWidth, // Dynamically calculated width
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 243, 239, 239),
              borderRadius: BorderRadius.circular(7),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.local_police, color: Color.fromARGB(255, 222, 4, 2)),
                Text("Mystery ",
                    style: TextStyle(color: Colors.black, fontSize: 12)),
              ],
            ),
          ),
          // Category 5
          Container(
            height: 60,
            width: itemWidth, // Dynamically calculated width
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 243, 239, 239),
              borderRadius: BorderRadius.circular(7),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.child_care, color: Color.fromARGB(255, 222, 4, 2)),
                Text("Children",
                    style: TextStyle(color: Colors.black, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
