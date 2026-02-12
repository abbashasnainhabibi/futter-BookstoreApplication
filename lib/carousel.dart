// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';

// class Mycarousel extends StatelessWidget {
//   const Mycarousel({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       shrinkWrap: true, // Prevent infinite height
//       children: [
//         Container(
//           height: 130, // Adjust height of the carousel container
//           child: CarouselSlider(
//             items: [
//               // First Image with Rounded Corners and Proper Fit
//               Container(
//                 margin: EdgeInsets.all(5.0), // Add margin for spacing
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20), // Rounded corners
//                   border: Border.all(color:  const Color.fromARGB(255, 35, 44, 106), width: 2), // Optional border
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(20), // Apply rounded corners to the image
//                   child: Image.asset(
//                     'assets/images/banner1.png',
//                     fit: BoxFit.cover, // Ensures the image covers the container properly
//                     width: double.infinity, // Image will take the full width of the container
//                     height: 200, // Ensure the height remains consistent
//                   ),
//                 ),
//               ),
//               // Second Image with Rounded Corners and Proper Fit
//               Container(
//                 margin: EdgeInsets.all(8.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20), // Rounded corners
//                   border: Border.all(color:  const Color.fromARGB(255, 35, 44, 106), width: 2), // Optional border
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: Image.asset(
//                     'assets/images/banner2.png',
//                     fit: BoxFit.cover, // Ensures the image covers the container properly
//                     width: double.infinity,
//                     height: 200,
//                   ),
//                 ),
//               ),
//               // Third Image with Rounded Corners and Proper Fit
//               Container(
//                 margin: EdgeInsets.all(8.0),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20), // Rounded corners
//                   border: Border.all(color: const Color.fromARGB(255, 35, 44, 106), width: 2), // Optional border
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: Image.asset(
//                     'assets/images/banner3.png',
//                     fit: BoxFit.cover, // Ensures the image covers the container properly
//                     width: double.infinity,
//                     height: 50,
//                   ),
//                 ),
//               ),
//             ],
//             options: CarouselOptions(
//               height: 200, // Ensure consistent height for carousel items
//               autoPlay: true,
//               enlargeCenterPage: true, // Highlight the center image
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';

// class Mycarousel extends StatelessWidget {
//   const Mycarousel({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(10.0),
//       decoration: BoxDecoration(
//         color: Colors.grey[300], // Background color of the container
//         borderRadius: BorderRadius.circular(15), // Border radius of 15
//         border: Border.all(color: const Color.fromARGB(255, 35, 44, 106), width: 2), // Optional border
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min, // Adjust the column to fit the content
//         children: [
//           Text(
//             "Featured Books", // Centered text at the top
//             style: TextStyle(
//               fontSize: MediaQuery.of(context).size.width * 0.05, // Scale text with screen size
//               color: const Color.fromARGB(255, 35, 44, 106), // Text color
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 10), // Space between text and carousel
//           Container(
//             child: CarouselSlider(
//               items: [
               
//               ],
//               options: CarouselOptions(
//                 height: MediaQuery.of(context).size.height * 0.3, // Carousel height scales with screen
//                 autoPlay: true,
//                 enlargeCenterPage: true, // Highlight the center image
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Helper function to build carousel items with rounded corners
//   Widget _buildCarouselItem(String imagePath) {
//     return Container(
//       margin: EdgeInsets.all(5.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15), // Rounded corners for the images
//         border: Border.all(color: const Color.fromARGB(255, 35, 44, 106), width: 2), // Optional border
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(15),
//         child: Image.asset(
//           imagePath,
//           fit: BoxFit.cover,
//           width: double.infinity,
//           height: 200, // Consistent height for each image
//         ),
//       ),
//     );
//   }
// }


import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Mycarousel extends StatelessWidget {
  const Mycarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 254, 247, 255), // Background color of the container
        borderRadius: BorderRadius.circular(15), // Border radius of 15
        border: Border.all(color: const Color.fromARGB(255, 254, 247, 255), width: 2), // Optional border
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Adjust the column to fit the content
        children: [
          Text(
            "", // Centered text at the top
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.02, // Scale text with screen size
              color: const Color.fromARGB(255, 35, 44, 106), // Text color
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5), // Space between text and carousel
          Container(
            child: CarouselSlider(
              items: [
                _buildCarouselItem(context, 'Slider 1', Colors.red),
                _buildCarouselItem(context, 'Slider 2', Colors.green),
                _buildCarouselItem(context, 'Slider 3', Colors.blue),
              ],
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.1, // Carousel height scales with screen
                autoPlay: true,
                enlargeCenterPage: true, // Highlight the center item
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to build carousel items with background color and centered text
  Widget _buildCarouselItem(BuildContext context, String text, Color color) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: color, // Background color for each slider
        borderRadius: BorderRadius.circular(15), // Rounded corners for the sliders
        border: Border.all(color: const Color.fromARGB(255, 35, 44, 106), width: 2), // Optional border
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.02, // Text size scales with screen size
            color: Colors.white, // Text color
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
