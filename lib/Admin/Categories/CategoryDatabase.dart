import 'package:cloud_firestore/cloud_firestore.dart';

class Catdatabase {
  final FirebaseFirestore _addcattofirestore = FirebaseFirestore.instance;

  // Method to add category with images
  static Future<void> addcatWithImages({
    required String catName,
    required String description,
    required List<String> base64Images,
  }) async {
    // Create a Map to hold the data
    Map<String, dynamic> categoryData = {
      'CategoryName': catName,
      'description': description,
      'images': base64Images, // Store the list of base64 images
      'createdAt': FieldValue.serverTimestamp(), // Optional: timestamp for when the category was created
    };

    try {
      // Add the category to the 'categories' collection in Firestore
      await FirebaseFirestore.instance.collection('categories').add(categoryData);
    } catch (e) {
      print("Error adding category: $e");
      throw e; // Re-throw the error for handling in the calling function
    }
  }
}