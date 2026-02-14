import 'dart:convert'; // For base64 decoding
import 'package:flutter/material.dart';
import 'cart_provider.dart';
import 'product_model.dart';
import 'package:bookstore/home.dart'; // Assuming Myhome is your home page

class Mycartlist extends StatefulWidget {
  const Mycartlist({super.key});

  @override
  State<Mycartlist> createState() => _MycartlistState();
}

class _MycartlistState extends State<Mycartlist> {
  late Future<List<Product>> _cartItemsFuture;

  @override
  void initState() {
    super.initState();
    _cartItemsFuture = CartProvider.getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text(
          "Cart Items",
          style: TextStyle(
              color: Color.fromARGB(255, 32, 32, 32), fontSize: 15),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Color.fromARGB(255, 92, 92, 92),
          ),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Myhome()));
          }
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: _cartItemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No items in the cart"));
          }

          final cartItems = snapshot.data!;

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final product = cartItems[index];
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 75,
                        height: 115,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: product.imagePath.isNotEmpty
                            ? Image.memory(
                                base64Decode(product.imagePath),
                                fit: BoxFit.cover,
                              )
                            : const Icon(Icons.error, color: Colors.red),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.name),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              product.price,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          await CartProvider.removeFromCart(index);
                          setState(() {
                            _cartItemsFuture = CartProvider.getCartItems();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
