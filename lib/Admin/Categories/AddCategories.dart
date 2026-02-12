import 'package:bookstore/Admin/Appbar.dart';
import 'package:bookstore/Admin/Books/Bookdatabase.dart';
import 'package:bookstore/Admin/Categories/CategoryDatabase.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCategory extends StatefulWidget {
  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController CatNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<String> base64Images = []; // Store Base64-encoded images

  final Catdatabase catdatabase = Catdatabase();

  @override

  // Pick and encode image to Base64
  Future<void> _pickAndEncodeImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      List<int> imageBytes = await pickedFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      setState(() {
        base64Images.add(base64Image);
      });
    }
  }

  // Add City to Firestore
  Future<void> addcatToFirestore() async {
    String catName = CatNameController.text.trim();
    String description = descriptionController.text.trim();

    // Validate inputs
    if (catName.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill all fields!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(255, 222, 4, 2),
      ));
      return;
    }

    try {
     
      await Catdatabase.addcatWithImages(
        catName: catName,
        description: description,
        base64Images: base64Images,
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Book Added Successfully!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromRGBO(146, 208, 80, 1),
      ));

      // Clear inputs after successful city addition
      CatNameController.clear();
      descriptionController.clear();

      setState(() {
        base64Images.clear();
      });
    } catch (e) {
      print("Error adding Category to Firestore: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error adding Category to Firestore'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(255, 222, 4, 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Panel',
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
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10),
                Text(
                  'Add New Category',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: Colors.grey[800],
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                _buildTextField('Category Name', CatNameController),
                SizedBox(height: 16),
                _buildTextField('Description', descriptionController,
                    maxLines: 4),

                SizedBox(height: 20),
                // Add Images Section
                Text(
                  'Add Images',
                  style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800]),
                ),
                SizedBox(height: 10),
                Wrap(
                  spacing: 15.0,
                  runSpacing: 15.0,
                  children: base64Images.map((base64Image) {
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                  color: Colors.grey[300]!, width: 1.0),
                            ),
                            child: Image.memory(
                              base64Decode(base64Image),
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                base64Images.remove(base64Image);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.redAccent,
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    onPressed: _pickAndEncodeImage,
                    icon: Icon(Icons.add_a_photo, color: Colors.white),
                    label: Text('Add Image',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                // Submit Button to Add City
                Center(
                  child: ElevatedButton(
                    onPressed: addcatToFirestore,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 50.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      elevation: 3,
                      shadowColor: Colors.greenAccent,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.book_rounded, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          'Add Book',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build text fields
  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 14, color: Colors.grey[700]),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      ),
    );
  }
}
