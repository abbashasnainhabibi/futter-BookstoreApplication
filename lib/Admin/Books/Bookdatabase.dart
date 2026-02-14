import 'package:cloud_firestore/cloud_firestore.dart';

class Bookdatabase {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addBookToFirestore({
    required String BookName,
    required String description,
    required double Bookprice,
    
    required String Bookcategory,
    required List<String> images,
  }) async {
    try {
      await firestore.collection('Books').add({
        'BookName': BookName,
        'description': description,
        'Bookprice': Bookprice,
        'BookCategory': Bookcategory,
       
        'images': images,
      });
    } catch (e) {
      print("Error adding book to Firestore: $e");
    }
  }

  Future<void> addBookWithImages({
    required String BookName,
    required String description,
    required double Bookprice,
   
    required String Bookcategory,
    required List<String> base64Images,
  }) async {
    try {
      await addBookToFirestore(
        BookName: BookName,
        description: description,
        Bookprice: Bookprice,
       
        Bookcategory: Bookcategory,
        images: base64Images,
      );
    } catch (e) {
      print("Error adding book with images: $e");
      throw e;
    }
  }
}
