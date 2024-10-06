import 'package:flutter/material.dart';
import 'login.dart'; // Import the LoginPage

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF2E9E2), // Background color for the whole page
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top icon and text
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    // Logo
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Center(
                        child: Image.asset(
                          'images/logo.png', // Local asset path
                          height: 200,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Slogan with background image
                    Container(
                      width: 300, // Matches the given layout width
                      height: 260, // Matches the given layout height
                      alignment: Alignment.center, // Centered text
                      child: Stack(
                        children: [
                          // Background image
                          Positioned.fill(
                            child: Image.asset(
                              'images/lines.png', // Background image path
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Text on top of the background image
                          Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                style: TextStyle(
                                  fontSize: 30,
                                  height:
                                      1.52, // Equivalent to 36.48px line height
                                  letterSpacing: 0.035,
                                  color: Colors.black, // Default text color
                                ),
                                children: <TextSpan>[
                                  // First line: "Helping you"
                                  TextSpan(
                                    text: 'Helping you\n',
                                    style: TextStyle(
                                      fontWeight:
                                          FontWeight.w400, // Regular weight
                                    ),
                                  ),
                                  // Second line: "to keep your bestie"
                                  TextSpan(
                                    text: 'to keep ',
                                    style: TextStyle(
                                      fontWeight:
                                          FontWeight.w400, // Regular weight
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'your bestie',
                                    style: TextStyle(
                                      fontWeight:
                                          FontWeight.w800, // Bold weight
                                      color: Color.fromARGB(
                                          255, 39, 120, 186), // Blue color
                                    ),
                                  ),
                                  // Third line: "stay healthy!"
                                  TextSpan(
                                    text: '\nstay healthy!',
                                    style: TextStyle(
                                      fontWeight:
                                          FontWeight.w400, // Regular weight
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Get Started Button with Paw Image and Illustration Image
            Container(
              height: 317,
              padding: const EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(65)),
              ),
              child: Stack(
                alignment: Alignment.center, // Center the content horizontally
                children: [
                  // Pets illustration (background image)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Image.asset(
                      'images/People caring for their pets.png', // Image asset path
                      height: 450, // Adjust height if necessary
                      width: 430,
                      fit: BoxFit
                          .cover, // Ensures the image fills the space without distortion
                    ),
                  ),
                  // Positioned Get Started Button (moved to bottom)
                  const Positioned(
                    bottom:
                        240, // Position the button closer to the bottom of the section
                    child:
                        GetStartedButton(), // Get Started button overlays at the bottom of the section
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// GetStartedButton Widget (StatefulWidget for color-changing effect)
class GetStartedButton extends StatefulWidget {
  const GetStartedButton({super.key});

  @override
  _GetStartedButtonState createState() => _GetStartedButtonState();
}

class _GetStartedButtonState extends State<GetStartedButton> {
  Color _buttonColor = const Color(0xFF0077B6); // Initial color

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      onTapDown: (_) {
        setState(() {
          _buttonColor = const Color.fromARGB(
              255, 10, 108, 164); // Change color when pressed
        });
      },
      onTapUp: (_) {
        setState(() {
          _buttonColor =
              const Color(0xFF00B4D8); // Revert to original color when released
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Button background
          Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              color: _buttonColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Center(
              child: Text(
                "Get Started",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Paw image overlay
          Positioned(
            right: 10,
            child: Image.asset(
              'images/Dog Paw.png', // Local asset path for the paw image
              height: 30, // Adjust the height as needed
              color:
                  Colors.white, // Optional: Change color to match button text
            ),
          ),
        ],
      ),
    );
  }
}
