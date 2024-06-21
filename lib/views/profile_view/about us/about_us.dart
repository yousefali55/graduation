import 'package:flutter/material.dart';
import 'package:graduation/theming/colors_manager.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        body: SizedBox(
      // Use SizedBox to control size explicitly
      width: screenSize.width,
      height: screenSize.height,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorsManager.mainGreen, Colors.tealAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                // Center the logo
                child: Image.asset(
                  // Assuming you have a logo
                  'images/logo circle.png', // Replace with your logo path
                  height: 100,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'The Renting System App Difference',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    // Add a subtle text shadow
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 2,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Connecting you with your dream home',
                style: TextStyle(
                  // Tagline with custom font and larger size
                  fontSize: 20,
                  fontFamily: 'Pacifico', // Example of a decorative font
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Our search, content, and advertising strategies are designed to bring millions of transaction-ready buyers and sellers to Renting System.com, where they can find a great agent, or connect to their current one and collaborate during the entire process.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'What We Offer:', // Change heading to be more concise
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    // Subtle text shadow
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 2,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              _buildBulletPoint(
                  'Extensive property listings'), // Updated bullet points
              _buildBulletPoint('Expert agent matching'),
              _buildBulletPoint('Personalized property recommendations'),
              _buildBulletPoint('Seamless communication tools'),
              _buildBulletPoint('Market insights and trends'),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 5), // Add padding between bullets
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.arrow_right, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Expanded(
              child: Text(text, style: const TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}
