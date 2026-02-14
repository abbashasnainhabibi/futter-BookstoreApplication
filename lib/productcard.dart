import 'dart:convert'; // For base64 decoding
import 'package:bookstore/productoverview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyProductCard extends StatelessWidget {
  const MyProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Fixed dimensions for the cards
    const double cardWidth = 140.0;
    const double cardHeight = 280.0; // Adjust height to fit larger image
    const double imageHeight = 200.0; // Increased height for the image

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0), // Add horizontal padding to create margins on the sides
      child: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('Books').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data.'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No books available.'));
          }

          var books = snapshot.data!.docs;

          return Wrap(
            spacing: 10.0, // Space between cards
            runSpacing: 10.0, // Space between rows of cards
            children: books.map((book) {
              var bookData = book.data() as Map<String, dynamic>;
              String base64Image = bookData['images'][0] ?? ''; // Assuming 'images' is a list
              String name = bookData['BookName'] ?? 'Unknown Book';
              String price = bookData['Bookprice'] != null ? ' ${bookData['Bookprice']}' : '';

              return _buildProductCard(
                context,
                base64Image,
                name,
              " Rs: $price",
                cardWidth,
                cardHeight,
                imageHeight,
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, String base64Image, String name,
      String price, double cardWidth, double cardHeight, double imageHeight) {
    return Container(
      width: cardWidth, // Fixed width
      height: cardHeight, // Adjusted height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 248, 246, 246),
      ),
      child: Column(
        children: [
          // GestureDetector around the image
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
            child: Container(
              height: imageHeight, // Increased height for the image
              width: cardWidth, // Ensure the image fills the width of the card
              padding: const EdgeInsets.all(8.0),
              child: base64Image.isNotEmpty
                  ? Image.memory(
                      base64Decode(base64Image), // Decode the base64 string
                      fit: BoxFit.cover, // Scale image to cover container
                    )
                  : const Icon(Icons.error, color: Colors.red), // Display error icon if no image
            ),
          ),
          // Product details section (name and price)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              name, // Display product name
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center, // Center align the text
            ),
          ),
          Text(price,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
