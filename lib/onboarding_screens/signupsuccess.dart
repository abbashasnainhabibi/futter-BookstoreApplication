import 'package:bookstore/credentials/login.dart';
import 'package:flutter/material.dart';

class Mysignupsuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( // Ensures content doesn't overlap with system UI
        child: SingleChildScrollView( // Allows scrolling if content overflows
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height, // Full height of the screen
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.white,
            ),
            child: Stack(
              alignment: Alignment.center, // Center the tick icon in the middle
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Green background for upper part
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 2, 73, 207),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Well Done!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Roboto',
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Your Account has been created successfully!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: 24,
                                fontWeight: FontWeight.normal,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Bottom white part with button
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.5,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Mylogin()), // Redirect to login page
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 50),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 56,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4), // Slightly rounded button
                                color:const Color.fromARGB(255, 2, 73, 207), // Green button color
                              ),
                              child: const Center(
                                child: Text(
                                  'Back to login', // Adjusted button text
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16, // Slightly larger button text size
                                    color: Colors.white, // White button text
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Circular container with icon, placed at the boundary of the green and white parts
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.42, // Dynamic position to avoid overflow
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white, // White background for circle
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1), // Light shadow
                          spreadRadius: 5,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.check, // Checkmark icon
                        color: Color.fromRGBO(146, 208, 80, 1), // Green color for icon
                        size: 80, // Large icon size
                      ),
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
}
