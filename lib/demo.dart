import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.brown),
          onPressed: () {},
        ),
        title: const Text(
          'CitiGuide',
          style: TextStyle(
            color: Colors.brown,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.brown),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              20.0, 20.0, 20.0, 20.0), // Left padding for the whole page
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF608BC1),

                  /// banner bg color//
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          'assets/images/1.jpeg', // Replace with your asset image path
                          fit: BoxFit.cover,
                          height: 80,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Explore Cities!',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Enjoy your tour!',
                            style:
                                TextStyle(color: Colors.white)), //text color//
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Categories Section
              Container(
                child: const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CategoryButton(
                          icon: 'assets/images/1.jpeg', label: 'Mountain'),
                      SizedBox(width: 8), // Space between buttons
                      CategoryButton(
                          icon: 'assets/images/1.jpeg', label: 'Beach'),
                      SizedBox(width: 8),
                      CategoryButton(
                          icon: 'assets/images/1.jpeg', label: 'Forest'),
                      // Add more categories if needed with SizedBox spacing
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Recommendations Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recommendation',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View All',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Recommended Places List (Horizontal Scroll)
              Container(
                padding: const EdgeInsets.all(
                    8), // Padding for the recommendation section
                child: SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      RecommendedPlace(
                        image: 'assets/images/1.jpeg',
                        title: 'Badshahi Mosque',
                        location: 'Lahore',
                        rating: 4.4,
                      ),
                      RecommendedPlace(
                        image: 'assets/images/1.jpeg',
                        title: 'Mohenjo-Daro',
                        location: 'Larkana',
                        rating: 4.2,
                      ),
                      RecommendedPlace(
                        image: 'assets/images/1.jpeg',
                        title: 'Karimabad Valley',
                        location: 'Hunza',
                        rating: 4.8,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Famous Destinations Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Famous Destinations',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View All',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Famous Destinations List (Vertical List)
              const Column(
                children: [
                  FamousDestination(
                    image: 'assets/images/1.jpeg',
                    title: 'Hunza Valley',
                    location: 'Gilgit-Baltistan',
                    description: 'Known for its breathtaking natural beauty.',
                    rating: 4.5,
                  ),
                  FamousDestination(
                    image: 'assets/images/1.jpeg',
                    title: 'Karimabad Hunza',
                    location: 'Gilgit-Baltistan',
                    description:
                        'Karimabad is a picturesque town in the valley.',
                    rating: 4.5,
                  ),
                  FamousDestination(
                    image: 'assets/images/1.jpeg',
                    title: 'Swat Valley',
                    location: 'Malakand district',
                    description: 'Known as the "Switzerland of the East."',
                    rating: 4.5,
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

class CategoryButton extends StatelessWidget {
  final String icon;
  final String label;

  const CategoryButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFCBDCEB),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(icon),
            radius: 20,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
                color: Colors.brown, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class RecommendedPlace extends StatelessWidget {
  final String image;
  final String title;
  final String location;
  final double rating;

  const RecommendedPlace({
    required this.image,
    required this.title,
    required this.location,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 16), // Spacing between cards
      padding: const EdgeInsets.all(8), // Padding inside each card
      decoration: BoxDecoration(
        color: Colors.grey[100],
        // Background color for each card
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image,
              height: 120,
              width: 160,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.brown,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.grey, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    location,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow[700], size: 16),
                  Text(rating.toString(),
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FamousDestination extends StatelessWidget {
  final String image;
  final String title;
  final String location;
  final String description;
  final double rating;

  const FamousDestination({
    required this.image,
    required this.title,
    required this.location,
    required this.description,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image,
              height: 110,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.brown,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow[700], size: 16),
                    Text(rating.toString(),
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
