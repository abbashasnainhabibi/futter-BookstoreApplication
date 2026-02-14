import 'dart:convert';
import 'dart:typed_data';

import 'package:bookstore/category_of_books/non-fiction.dart';
import 'package:bookstore/productoverview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Myviewmore_nonfiction extends StatelessWidget {
  final User? user;
  const  Myviewmore_nonfiction({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {},
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Mycategorynonfiction(user: user)));
            },
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("${user?.displayName ?? "user"}", style: const TextStyle(color: Colors.black, fontSize: 15)),
            const SizedBox(width: 10),
            CircleAvatar(
               backgroundColor: Colors.white,
              backgroundImage: user?.photoURL != null
                          ? NetworkImage(user!.photoURL!)
                          : const AssetImage('assets/images/profile.png') as ImageProvider,
              radius: 18,
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFictionBooksList(context),
            ],
          ),
        ),
      ),
    );
  }

  // FutureBuilder to fetch and display fiction books (from Firebase)
  Widget _buildFictionBooksList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Non-Fiction Books',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        // FutureBuilder to fetch and display fiction books from Firestore
        FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('Books') // Firestore collection
              .where('BookCategory', isEqualTo: 'Non-Fiction') // Filter by category
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Error fetching data.'));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No non-fiction books available.'));
            }

            var books = snapshot.data!.docs;

            return ListView.builder(
              shrinkWrap: true, // Prevent overflow in non-scrolling parent
              physics: const NeverScrollableScrollPhysics(),
              itemCount: books.length, // Display the fetched books
              itemBuilder: (context, index) {
                var book = books[index].data() as Map<String, dynamic>;

                // Extract fields with safe defaults
                String imagePath = (book['images'] is List) ? book['images'][0] : book['images'] ?? '';
                String name = book['BookName'] ?? 'Unknown Name';
                String price = book['Bookprice'] != null ? book['Bookprice'].toString() : '0';
                String description = book['description'] ?? 'No description available';

                return _buildFictionBookItem(
                  imagePath,
                  name,
                    " Rs: $price",
                  description,
                  context,
                );
              },
            );
          },
        ),
      ],
    );
  }

  // Method to build each book item
  Widget _buildFictionBookItem(String base64Image, String name, String price, String description, BuildContext context) {
    Uint8List? imageBytes;

    // Decode Base64 string if it's not empty
    if (base64Image.isNotEmpty) {
      try {
        imageBytes = base64Decode(base64Image);
      } catch (e) {
        print("Error decoding Base64 image: $e");
      }
    }

    return Card(
      color: const Color.fromARGB(255, 248, 246, 246),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0), // Optional: Rounded corners for the image
          child: imageBytes != null
              ? Image.memory(
                  imageBytes,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/images/placeholder.jpg', // Placeholder image
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description, style: const TextStyle(fontSize: 12, color: Colors.black54)),
            Row(
              children: [
                Text(price, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => My_productoverview(
                      imagePath: base64Image,
                      name: name,
                      price: price,
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.green,
              ),
            ),
            const Text(
              'Add to cart',
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
