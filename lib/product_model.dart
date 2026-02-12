import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String imagePath;
  final String name;
  final String price;

  Product({
    required this.imagePath,
    required this.name,
    required this.price,
  });
}
