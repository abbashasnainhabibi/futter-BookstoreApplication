import 'package:bookstore/demo.dart';
import 'package:bookstore/home.dart';
import 'package:bookstore/credentials/login.dart';
import 'package:bookstore/onboarding_screens/loginsuccess.dart';
import 'package:bookstore/onboarding_screens/signupsuccess.dart';
import 'package:bookstore/services/google_signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Mysignup extends StatefulWidget {
  const Mysignup({super.key});

  @override
  State<Mysignup> createState() => _MysignupState();
}

class _MysignupState extends State<Mysignup> {
  String email = "", password = "", name = "";

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  Future<void> registration() async {
  if (_formkey.currentState!.validate()) {
    setState(() {
      email = emailcontroller.text;
      name = namecontroller.text;
      password = passwordcontroller.text;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Update user profile with display name
      await userCredential.user?.updateProfile(displayName: namecontroller.text);

      // Show SnackBar for registration success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registration Successful!"),
          duration: Duration(seconds: 2),
          backgroundColor: Color.fromRGBO(146, 208, 80, 1),
        ),
      );

      // Navigate to login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  Mysignupsuccess()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      if (e.code == 'weak-password') {
        errorMessage = "Password provided is too weak.";
      } else if (e.code == "email-already-in-use") {
        errorMessage = "Account already exists.";
      } else if (e.code == "invalid-email") {
        errorMessage = "The email address is badly formatted.";
      } else {
        errorMessage = "An unexpected error occurred: ${e.message}";
      }

      // Show SnackBar for errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: const Duration(seconds: 2),
          backgroundColor: const Color.fromARGB(255,222, 4, 2),
        ),
      );
    }
  } else {
    // Show SnackBar if fields are empty
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please fill all the fields."),
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromARGB(255,222, 4, 2),
      ),
    );
  }
}


  bool _isPasswordVisible = false;

  bool _agreeToTerms = false;
  final Color bluecolor =
      const Color.fromARGB(255, 2, 73, 207); // Define the blue color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50), // Add space from the top

                // Logo at the top
                Image.asset(
                  'assets/images/icons,logos/logo.png', // Replace with your logo image path
                  height: 100,
                ),
                const SizedBox(height: 20),

                // Sign Up Text
                const Text(
                  'Sign up for Bookstore',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),

                // First Name TextFormField
                TextFormField(
                  controller: namecontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter Your First Name';
                    }
                    return null;
                  },
                  cursorColor: const Color.fromARGB(255, 222, 4, 2),
                  decoration: const InputDecoration(
                      labelText: 'First Name',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 0.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.grey,
                      ))),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),

                // Email TextFormField
                TextFormField(
                  controller: emailcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter Your email';
                    }
                    return null;
                  },
                  cursorColor: const Color.fromARGB(255, 222, 4, 2),
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 0.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.grey,
                      ))),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),

                // Password TextFormField
                TextFormField(
                  controller: passwordcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter Your Password';
                    }
                    return null;
                  },
                  cursorColor: const Color.fromARGB(255, 222, 4, 2),
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 0.5,
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.grey,
                    )),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 5),

                // Checkbox for "I Agree to Terms and Conditions"
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Checkbox(
                        value: _agreeToTerms,
                        onChanged: (value) {
                          setState(() {
                            _agreeToTerms = value!;
                          });
                        },
                        activeColor: const Color.fromARGB(255, 2, 73, 207),
                        checkColor: Colors.white,
                      ),
                    ),
                    const Expanded(
                      child: Text('I Agree to Terms and Conditions'),
                    ),
                  ],
                ),
                const SizedBox(height: 5),

                // Sign Up Button
                // Sign Up Button
              // Sign Up Button
SizedBox(
  width: double.infinity,
  child: ElevatedButton(
  onPressed: () {
    if (_formkey.currentState!.validate()) {
      if (!_agreeToTerms) {
        // Show a SnackBar if the user has not agreed to the terms
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please agree to the Terms and Conditions to continue."),
            duration: Duration(seconds: 2), // Duration for which the SnackBar is displayed
            backgroundColor: Color.fromARGB(255, 222, 4, 2), // Set the background color of the SnackBar
          ),
        );
      } else {
        registration(); // Proceed with the registration process
      }
    } else {
      // Show SnackBar if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all the fields."),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  },
  style: TextButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    backgroundColor: const Color.fromARGB(255, 2, 73, 207),
    shape: RoundedRectangleBorder(
      side: const BorderSide(
        color: Colors.grey, // Border color same as text fields
        width: 1, // Border width
      ),
      borderRadius: BorderRadius.circular(4), // Same border radius as the input fields
    ),
  ),
  child: const Center(
    child: Text(
      'SIGN UP',
      style: TextStyle(
        color: Colors.white,
        fontSize: 13, // Same size as the input fields text
      ),
    ),
  ),
),

),

                const SizedBox(
                  height: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("or connect with"),
                      ],
                    ),
                    const SizedBox(height: 15), // Add space below the divider

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Flexible widget to prevent overflow
                         Flexible(
                          child: GestureDetector(
                            onTap: () {
                              AuthMethods().signInWithGoogle(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(0.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    12), // Rounded corners
                                border: Border.all(
                                  color: Colors.grey, // Border color
                                  width: 1.5, // Border width
                                ),
                              ),
                              height: 54, // Fixed height for container
                              width: 54, // Fixed width for container
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    12), // Ensure the image also respects the container's border radius
                                child: Image.asset(
                                  'assets/images/icons,logos/google.png',
                                  fit: BoxFit
                                      .cover, // Ensures the image covers the entire box
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                            width:
                                20), // Space between Google and Apple buttons

                        // Flexible widget to prevent overflow
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              // Implement Apple sign-in logic
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    12), // Rounded corners
                                border: Border.all(
                                  color: Colors.grey, // Border color
                                  width: 1.5, // Border width
                                ),
                              ),
                              child: const FaIcon(
                                FontAwesomeIcons.apple,
                                color: Colors.black,
                                size: 25, // Icon size
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already registered?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const Mylogin()));
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Color.fromARGB(255, 222, 4, 2)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
