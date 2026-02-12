import 'dart:convert';

import 'package:bookstore/Admin/Appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ShowBooks extends StatelessWidget {
  // Function to show the edit dialog
  Future<void> _showEditDialog(
      BuildContext context, DocumentSnapshot Book) async {
    // TextEditingControllers for city properties
    final BookNameController = TextEditingController(text: Book['BookName']);
    final descriptionController =
        TextEditingController(text: Book['description']);
    final BookpriceController =
        TextEditingController(text: Book['Bookprice'].toString());
   
    final BookCategoryController =
        TextEditingController(text: Book['BookCategory'].toString());

    showDialog(
      context: context,
      builder: (context) {
       return AlertDialog(
        backgroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
  title: const Text(
    'Edit Book',
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: Colors.black87,
    ),
    textAlign: TextAlign.center,
  ),
  content: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTextField(BookNameController, 'BookName'),
                const SizedBox(height: 10),
                _buildTextField(descriptionController, 'Description', maxLines: 5),
                const SizedBox(height: 10),
                _buildTextField(BookCategoryController, 'BookCategory '),
                const SizedBox(height: 10),
                _buildTextField(BookpriceController, 'Bookprice', keyboardType: const TextInputType.numberWithOptions(decimal: true)),
               
      ],
    ),
  ),
  actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  actions: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Cancel Button
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey[700],
          ),
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        // Save Button
        ElevatedButton(
          onPressed: () async {
            final updatedBookName = BookNameController.text.trim();
            final updatedDescription = descriptionController.text.trim();
            final updatedBookCategory = BookCategoryController.text.trim();

            final updatedBookprice = double.tryParse(BookpriceController.text.trim()) ?? 0.0;
           

            await FirebaseFirestore.instance
                .collection('Books')
                .doc(Book.id)
                .update({
              'BookName': updatedBookName,
              'description': updatedDescription,
              'BookCategory': updatedBookCategory,
              'Bookprice': updatedBookprice,
            
            }).then((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Book updated successfully!"),
        behavior: SnackBarBehavior.floating,

                  backgroundColor: Colors.green,
                ),
              );
            }).catchError((error) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Failed to update Book!"),
        behavior: SnackBarBehavior.floating,

                  backgroundColor: Colors.red,
                ),
              );
            });

            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'Save',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ],
    ),
  ],
);

      },
    );
  }

  // Helper method to build the text fields
  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.white),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
    );
  }

  // Method to build each city card
  Widget buildCityCard(BuildContext context, DocumentSnapshot Book) {
    return Card(
      color: const Color.fromARGB(255, 240, 239, 239),
      elevation: 15,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display image if available
            if (Book['images'] != null && Book['images'].isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.memory(
                  base64Decode(Book['images'][0]),
                  width: 130,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Book['BookName'],
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 2, 73, 207),
                    ),
                  ),
                  Text(
                    "BookPrice: ${Book['Bookprice'].toStringAsFixed(2)}",
                    style: const TextStyle(color: Colors.black, fontSize: 14.0),
                    overflow: TextOverflow.ellipsis,
                  ),
                
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(LineAwesomeIcons.tag_solid, size: 30, color: Colors.black),
                      const SizedBox(width: 4.0),
                      Expanded(
                        child: Text(
                          Book['BookCategory'],
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Color.fromARGB(255, 51, 102, 196),
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          _showEditDialog(context, Book);
                        },
                        child: const Text(
                          "Edit",
                          style: TextStyle(color: Colors.green, fontSize: 14.0),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('Books')
                              .doc(Book.id)
                              .delete();
                        },
                        child: const Text(
                          "Delete",
                          style: TextStyle(
                            color: Color.fromARGB(255, 222, 4, 2),
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'All Books',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: const CustomDrawer(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Books').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No Books added yet.',
                style: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
              ),
            );
          }

          var cities = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: cities.length,
            itemBuilder: (context, index) {
              var city = cities[index];
              return buildCityCard(context, city);
            },
          );
        },
      ),
    );
  }
}
