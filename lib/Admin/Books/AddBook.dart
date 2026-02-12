import 'package:bookstore/Admin/Appbar.dart';
import 'package:bookstore/Admin/Books/Bookdatabase.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddBook extends StatefulWidget {
  @override
  _AddBookState createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final TextEditingController BookNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController BookpriceController = TextEditingController();

  final TextEditingController BookcategoryController = TextEditingController();

  List<String> base64Images = []; // Store Base64-encoded images
  List<String> categories = []; // Store province names
  String? selectedCategory; // Selected province from the dropdown

  final Bookdatabase bookdatabase = Bookdatabase();
  bool _isLoadingcat = true; // Flag to check if provinces are loading

  @override
  void initState() {
    super.initState();
    _fetchcategory(); // Fetch provinces when the widget is first created
  }

// Fetch categories from Firestore
Future<void> _fetchcategory() async {
  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('categories').get();
    setState(() {
      categories = snapshot.docs.map((doc) => doc['CategoryName'] as String).toList();
      if (categories.isNotEmpty) {
        selectedCategory = categories[0]; // Set initial selection to the first category
      }
      _isLoadingcat = false; // Provinces are loaded, stop loading indicator
    });
  } catch (e) {
    print('Error fetching categories: $e');
    setState(() {
      _isLoadingcat = false; // Stop loading even if there was an error
    });
  }
}

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

  // Add book to Firestore
  Future<void> _addBookToFirestore() async {
    String BookName = BookNameController.text.trim();
    String description = descriptionController.text.trim();
    String Bookprice = BookpriceController.text.trim();
    String Bookcategory = BookcategoryController.text.trim();

    // Validate inputs
    if (BookName.isEmpty ||
        description.isEmpty ||
        Bookprice.isEmpty 
       ) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill all fields!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(255, 222, 4, 2),
      ));
      return;
    }

    try {
      // Convert latitude and longitude to double
      double price = double.tryParse(Bookprice) ?? 0.0;

      await bookdatabase.addBookWithImages(
        BookName: BookName,
        description: description,
        Bookprice: price,
        Bookcategory: selectedCategory!,
        base64Images: base64Images,
      );

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Book Added Successfully!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromRGBO(146, 208, 80, 1),
      ));

      // Clear inputs after successful city addition
      BookNameController.clear();
      descriptionController.clear();
      BookpriceController.clear();

      BookcategoryController.clear();
      setState(() {
        base64Images.clear();
        selectedCategory = null;
      });
    } catch (e) {
      print("Error adding Book to Firestore: $e");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error adding Book to Firestore'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(255, 222, 4, 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
      drawer: const CustomDrawer(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Text(
                  'Add New Book',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: Colors.grey[800],
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField('City Name', BookNameController),
                const SizedBox(height: 16),
                _buildTextField('Description', descriptionController,
                    maxLines: 4),

                const SizedBox(height: 16),
        Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      'Select Category',
      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
    ),
    const SizedBox(height: 8),
    _isLoadingcat
        ? const Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                color: Colors.blueAccent,
              ),
            ),
          )
        : DropdownButtonFormField<String>(
            value: selectedCategory, // Ensure this is not null when rendered
            hint: Text(
              'Select a Category',
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[500]),
            ),
            onChanged: (String? newValue) {
              setState(() {
                selectedCategory = newValue;  // Update selectedCategory when user selects a category
              });
            },
            items: categories.isEmpty
                ? [const DropdownMenuItem(value: null, child: Text('No categories available'))]
                : categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(
                        category,
                        style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
                      ),
                    );
                  }).toList(),
            decoration: InputDecoration(
              labelText: 'Category ',
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
                borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            ),
            dropdownColor: Colors.white,
            elevation: 4,
            iconEnabledColor: Colors.blue,
            iconSize: 24.0,
          ),
  ],
),

                const SizedBox(height: 16),
                _buildTextField('Bookprice', BookpriceController),

                const SizedBox(height: 20),
                // Add Images Section
                Text(
                  'Add Images',
                  style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800]),
                ),
                const SizedBox(height: 10),
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
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.redAccent,
                              ),
                              child: const Icon(
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
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    onPressed: _pickAndEncodeImage,
                    icon: const Icon(Icons.add_a_photo, color: Colors.white),
                    label: const Text('Add Image',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                // Submit Button to Add City
                Center(
                  child: ElevatedButton(
                    onPressed: _addBookToFirestore,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
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
                        const Icon(Icons.book_rounded, color: Colors.white),
                        const SizedBox(width: 10),
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
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      ),
    );
  }
}
