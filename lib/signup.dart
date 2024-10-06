import 'package:flutter/material.dart';
import 'home.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscureText = true;
  bool _obscureConfirmText = true; // for confirm password field
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Color variables for Google and Apple buttons
  Color _googleButtonColor = Color(0xFF00B4D8);
  Color _appleButtonColor = Color(0xFF00B4D8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // App logo
                  Image.asset('images/logo.png', height: 100),
                  SizedBox(height: 20),

                  // Infographic image added below the logo
                  Image.asset(
                    'images/inforgraphics2.png',
                    height: 150,
                    fit: BoxFit.cover,
                  ),

                  // Sign Up Form
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Username field
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            hintText: 'Username',
                            prefixIcon: Icon(Icons.person_outline),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 215, 228, 250),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Please enter your username';
                            return null;
                          },
                        ),
                        SizedBox(height: 20),

                        // Email field
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Email Address',
                            prefixIcon: Icon(Icons.email_outlined),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 215, 228, 250),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Please enter your email';
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value))
                              return 'Please enter a valid email';
                            return null;
                          },
                        ),
                        SizedBox(height: 20),

                        // Password field
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 215, 228, 250),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Please enter your password';
                            return null;
                          },
                        ),
                        SizedBox(height: 20),

                        // Confirm Password field
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirmText,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureConfirmText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmText = !_obscureConfirmText;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 215, 228, 250),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Please confirm your password';
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),

                        // Forgot Password link
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

                        // Sign Up button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(
                                      username: _usernameController.text,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text('Sign Up',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF00B4D8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),

                        // Already have an account? Login
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already Have an Account? ",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15, // Set font to Poppins
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontFamily: 'Poppins', // Set font to Poppins
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
                        SizedBox(height: 8),

                        // Or Sign Up with section
                        Column(
                          children: [
                            Text(
                              'Or',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15, // Set font to Poppins
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Sign Up With',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 15, // Set font to Poppins
                              ),
                            ),
                            SizedBox(height: 20),

                            // Row for Google and Apple login buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Google login button
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(
                                          username: "Google User",
                                        ),
                                      ),
                                    );
                                  },
                                  onTapDown: (_) {
                                    setState(() {
                                      _googleButtonColor = const Color.fromARGB(
                                          255, 10, 108, 164);
                                    });
                                  },
                                  onTapUp: (_) {
                                    setState(() {
                                      _googleButtonColor = Color(0xFF00B4D8);
                                    });
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: _googleButtonColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage:
                                            AssetImage('images/Google.png'),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),

                                // Apple login button
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(
                                          username: "Apple User",
                                        ),
                                      ),
                                    );
                                  },
                                  onTapDown: (_) {
                                    setState(() {
                                      _appleButtonColor = const Color.fromARGB(
                                          255, 10, 108, 164);
                                    });
                                  },
                                  onTapUp: (_) {
                                    setState(() {
                                      _appleButtonColor = Color(0xFF00B4D8);
                                    });
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: _appleButtonColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: Colors.transparent,
                                        backgroundImage:
                                            AssetImage('images/Apple Logo.png'),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        // Bottom illustration image with oval background
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            // Oval shape background
                            Container(
                              width: 474.28,
                              height: 800.44,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(168, 134, 211, 200),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.elliptical(300, 200),
                                  topRight: Radius.elliptical(300, 200),
                                ),
                              ),
                            ),
                            Image.asset('images/ink.png', height: 900),
                            // Add this line inside the Stack, right before the last closing bracket
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset('images/ink.png', height: 900),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
