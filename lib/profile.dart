import 'package:accordion/accordion.dart';
import 'package:bookstore/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Myprofile extends StatelessWidget {
  final User? user;

  const Myprofile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Adjust vertical padding
            child: Align(
              alignment: Alignment.centerLeft, // Aligns the text to the left
              child: Text(
                "My Profile",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          centerTitle: false, // Ensures the title is not centered
          leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => const Myhome()));
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Container(
                      width: 170, // Match the image dimensions
                      height: 170,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // Ensures the border is circular
                        border: Border.all(
                          color:const Color.fromARGB(255, 2, 73, 207),// Set the border color to red
                          width: 2.5, // Border width
                        ),
                      ),
                      child: ClipOval(
                        child: user?.photoURL != null
                            ? Image.network(
                                user!.photoURL!, // Load image from URL
                                fit: BoxFit.cover,
                                width: 170,
                                height: 170,
                              )
                            : Image.asset(
                                "assets/images/profile.png", // Fallback to local asset
                                fit: BoxFit.cover,
                                width: 170,
                                height: 170,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    child: Accordion(
                      maxOpenSections: 1, // Ensures only one section is open at a time
                      headerBackgroundColorOpened: const Color.fromARGB(234, 199, 193, 193),
                      children: [
                        AccordionSection(
                          headerPadding: const EdgeInsets.all(9), // Custom padding
                          headerBackgroundColor: const Color.fromARGB(234, 199, 193, 193),
                          headerBackgroundColorOpened: Colors.blueGrey,
                          leftIcon: const Icon(Icons.account_circle),
                          rightIcon: const Icon(Icons.arrow_forward_ios),
                          header: const Text("My Account"),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Creating a similar design to the provided image
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  children: [
                                    const Text(
                                      "Email: ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        user?.email ?? "Email Not Available",
                                        style: const TextStyle(
                                          color: Color(0xFF1DA1F2),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      "Edit",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Divider for separation
                              Row(
                                children: [
                                  const Text(
                                    "Name: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      user?.displayName ?? "",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF1DA1F2)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Row(
                                children: [
                                  Text(
                                    "Phone: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Row(
                                children: [
                                  Text(
                                    "DOB: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Row(
                                children: [
                                  Text(
                                    "Country: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "  ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Row(
                                children: [
                                  Text(
                                    "City: ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Expanded(
                                    child: Text(
                                      " ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Row(
                                children: [
                                  Text(
                                    "Zip Code: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        AccordionSection(
                          headerPadding: const EdgeInsets.all(9), // Custom padding
                          headerBackgroundColor: const Color.fromARGB(234, 199, 193, 193),
                          headerBackgroundColorOpened: Colors.blueGrey,
                          leftIcon: const Icon(Icons.notifications),
                          rightIcon: const Icon(Icons.arrow_forward_ios),
                          header: const Text("Notification"),
                          content: const Text("Notification settings go here."),
                        ),
                        AccordionSection(
                          headerPadding: const EdgeInsets.all(9), // Custom padding
                          headerBackgroundColor: const Color.fromARGB(234, 199, 193, 193),
                          headerBackgroundColorOpened: Colors.blueGrey,
                          leftIcon: const Icon(Icons.settings),
                          rightIcon: const Icon(Icons.arrow_forward_ios),
                          header: const Text("Settings"),
                          content: const Text("Settings details go here."),
                        ),
                        AccordionSection(
                          headerPadding: const EdgeInsets.all(9), // Custom padding
                          headerBackgroundColor: const Color.fromARGB(234, 199, 193, 193),
                          headerBackgroundColorOpened: Colors.blueGrey,
                          leftIcon: const Icon(Icons.help_center_rounded),
                          rightIcon: const Icon(Icons.arrow_forward_ios),
                          header: const Text("Help Centre"),
                          content: const Text("Help Centre details go here."),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
