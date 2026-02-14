import 'dart:convert'; // For base64 decoding
import 'dart:typed_data'; // For Uint8List
import 'package:bookstore/cart_provider.dart';
import 'package:bookstore/cartlist.dart';
import 'package:bookstore/product_model.dart';
import 'package:flutter/material.dart';

class My_productoverview extends StatelessWidget {
  final String imagePath; // This will be the base64 string of the image
  final String name;
  final String price;
 



  const My_productoverview({
    super.key,
    required this.imagePath,
    required this.name,
    required this.price,
   

  });

  @override
  Widget build(BuildContext context) {
       final product = Product(imagePath: imagePath, name: name, price: price);
    final decodedImage = _decodeBase64Image(imagePath); // Decode the base64 image

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            decodedImage != null
                ? Image.memory(
                    decodedImage, // Use the decoded image
                    width: 400,
                    height: 350,
                  )
                : const CircularProgressIndicator(), // Show loading if decoding is in progress
            Text(name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(" $price", style: const TextStyle(fontSize: 20)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: MaterialButton(
                height: 40,
                minWidth: double.infinity,
                onPressed: () async {
                   await CartProvider.addToCart(product);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Mycartlist()),
                  );
                },
                textColor: Colors.white,
                color: Colors.redAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: const Text("Add to cart"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to decode base64 string to image
  Uint8List? _decodeBase64Image(String base64String) {
    try {
      return base64Decode(base64String); // Decode the base64 string to bytes
    } catch (e) {
      print("Error decoding base64 image: $e");
      return null; // Return null in case of an error
    }
  }
}
