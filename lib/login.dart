import 'package:flutter/material.dart';
import 'home.dart'; // Import HomePage for navigation

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  String? _username;
  String? _password;

  // State variables to track if Google or Apple buttons are pressed
  bool _isGooglePressed = false;
  bool _isApplePressed = false;

  final _formKey = GlobalKey<FormState>();

  // Function to check if the login button should be enabled
  bool get _isLoginEnabled =>
      _username != null &&
      _username!.isNotEmpty &&
      _password != null &&
      _password!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey, // Wrap the form fields inside a Form widget
                child: Column(
                  children: [
                    // App logo
                    Image.asset(
                      'images/logo.png', // Replace with your app logo path
                      height: 150,
                    ),

                    // Infographic image added below the logo
                    Image.asset(
                      'images/infographics.png', // Path to your infographic image
                      height: 150, // Adjust the size accordingly
                      fit: BoxFit.cover,
                    ),

                    // Username text field
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color(0xffE5E5E5),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _username = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Password text field
                    TextFormField(
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color(0xffE5E5E5),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Login button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoginEnabled
                            ? () {
                                // Validate the form
                                if (_formKey.currentState!.validate()) {
                                  // Navigate to HomePage and pass the username
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          HomePage(username: _username!),
                                    ),
                                  );
                                }
                              }
                            : null, // Disable button if validation fails
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color(0xFF00B4D8),
                          backgroundColor: _isLoginEnabled
                              ? const Color(0xFF00B4D8)
                              : const Color(0xFF00B4D8),
                          // Button color depends on validation
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    // Forgot password link
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Handle forgot password
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color(
                                0xFF0077B6), // Replace with your custom color

                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Sign up link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't Have an Account? ",
                          style: TextStyle(
                            fontSize: 15, // Set font to Poppins
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xFF0077B6),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          splashColor: Colors
                              .lightBlueAccent, // Highlight color when tapped
                        ),
                      ],
                    ),
                    SizedBox(height: 4),

                    // Login with Google or Apple
                    Column(
                      children: [
                        Text(
                          'Or',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Login with',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        // Google login button
                        GestureDetector(
                          onTapDown: (_) {
                            setState(() {
                              _isGooglePressed =
                                  true; // Change color when pressed
                            });
                          },
                          onTapUp: (_) {
                            setState(() {
                              _isGooglePressed =
                                  false; // Revert to original color when released
                            });
                            // Handle Google login
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HomePage(username: "GoogleUser"),
                              ),
                            );
                          },
                          onTapCancel: () {
                            setState(() {
                              _isGooglePressed =
                                  false; // Revert to original color if gesture is canceled
                            });
                          },
                          child: Center(
                            child: CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage('images/Google.png'),
                            ),
                          ),
                        ),

                        // Apple login button
                        GestureDetector(
                          onTapDown: (_) {
                            setState(() {
                              _isApplePressed =
                                  true; // Change color when pressed
                            });
                          },
                          onTapUp: (_) {
                            setState(() {
                              _isApplePressed =
                                  false; // Revert to original color when released
                            });
                            // Handle Apple login
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HomePage(username: "AppleUser"),
                              ),
                            );
                          },
                          onTapCancel: () {
                            setState(() {
                              _isApplePressed =
                                  false; // Revert to original color if gesture is canceled
                            });
                          },
                          child: Center(
                            child: CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  AssetImage('images/Apple Logo.png'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 70,
                        ),
                      ],
                    ),

                    // Illustration image at the bottom
                    Image.asset(
                      'images/ink-shape.png', // Replace with your illustration path
                      height: 200,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
