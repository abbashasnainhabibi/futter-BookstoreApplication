import 'dart:convert';
import 'dart:typed_data';

import 'package:bookstore/home.dart';
import 'package:bookstore/productoverview.dart';
import 'package:bookstore/view_more_items_from_category/fiction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Mycategoryfiction extends StatelessWidget {
  final User? user;
  const Mycategoryfiction({super.key, required this.user});

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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Myhome()));
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
      drawer: const Drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRetailNetworkSearch(),
              const SizedBox(height: 15),
              _buildCounterfeitAlert(),
              const SizedBox(height: 20),
              _buildScanningHistory(context),
            ],
          ),
        ),
      ),
    );
  }

  // Retail Network Search widget
  Widget _buildRetailNetworkSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Fiction', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Container(
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: const DecorationImage(
              image: AssetImage('assets/images/2.jpeg'), // Banner Image
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search By Name',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Fetch and display fiction books limited to 5
Widget _buildScanningHistory(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Fiction Books',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Myviewmore_fiction(user: user),
                ),
              );
            },
            child: const Text(
              'View More',
              style: TextStyle(color: Colors.green, fontSize: 14),
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      // FutureBuilder to fetch and display data
      FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('Books') // Firestore collection
            .where('BookCategory', isEqualTo: 'Fiction') // Filter by category
            .limit(5) // Limit to 5 books
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data.'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No fiction books available.'));
          }

          var books = snapshot.data!.docs;

          return ListView.builder(
            shrinkWrap: true, // Prevents overflow in non-scrolling parent
            physics: const NeverScrollableScrollPhysics(),
            itemCount: books.length, // Display up to 5 books
            itemBuilder: (context, index) {
              var book = books[index].data() as Map<String, dynamic>;

              // Extract fields with safe defaults
              String imagePath = (book['images'] is List) ? book['images'][0] : book['images'] ?? '';
              String name = book['BookName'] ?? 'Unknown Name';
              String price = book['Bookprice'] != null ? book['Bookprice'].toString() : '0';
              String description = book['description'] ?? 'No description available';

              return _buildScanHistoryItem(
                imagePath,
                name,
              " Rs: $price",
                'Fiction',
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



Widget _buildScanHistoryItem(String base64Image, String name, String price, String category, String description, BuildContext context) {
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
              const SizedBox(width: 5),
              Text(category, style: const TextStyle(fontSize: 12, color: Colors.black54)),
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



  // Hot Selling Book Section
  Widget _buildCounterfeitAlert() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hot Selling Book',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '',
              style: TextStyle(color: Colors.green, fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 240, 236, 236),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/images/fiction books/The Great Gatsby.jpg',
                height: 50,
              ), // Book Image
              const SizedBox(width: 15),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'The Great Gatsby',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      'A tragic story of Jay Gatsby and his unrequited love for Daisy Buchanan in the Roaring Twenties.',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
