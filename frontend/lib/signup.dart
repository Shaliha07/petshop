import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shane_and_shawn_petshop/token_manager.dart';
import 'home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscureText = true;
  bool _obscureConfirmText = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final String appleUserName = "AppleUser";
  final String googleUserName = "GoogleUser";
  // final storage = FlutterSecureStorage();

  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      // Get username, email and password
      String username = _usernameController.text!;
      String email = _emailController.text!;
      String password = _confirmPasswordController.text!;

      // Send a POST request to the server
      final url = Uri.parse('${dotenv.env['LOCAL_IP']}/auth/register');

      try {
        // Make the POST request
        final response = await http.post(url,
            headers: {
              "Content-Type": "application/json",
            },
            body: jsonEncode({
              "username": username,
              "email": email,
              "password": password,
            }));

        // Check if the response is successful
        if (response.statusCode == 201) {
          // Parse the response
          final responseData = jsonDecode(response.body);
          String token = responseData['token'];

          // Store token in TokenManager
          await TokenManager.instance.setAccessToken(token);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Register Successful'),
            backgroundColor: Colors.green,
          ));

          // Handle success, navigate to the home page
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(username: username)),
          );
        } else {
          // Handle error, show a message
          final responseData = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(responseData['message'] ?? 'Register Failed'),
            backgroundColor: Colors.red,
          ));
        }
      } catch (error) {
        print("Error: $error");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('An error occurred. Please try again later. : $error'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

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
                  Image.asset('images/logo.png', height: 150),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      'images/hexagon_right.png',
                      height: 125,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            hintText: 'Username',
                            prefixIcon: const Icon(Icons.person_outline),
                            filled: true,
                            fillColor: const Color(0xffE5E5E5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Email Address',
                            prefixIcon: const Icon(Icons.email_outlined),
                            filled: true,
                            fillColor: const Color(0xffE5E5E5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                            prefixIcon: const Icon(Icons.lock_outline),
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
                            fillColor: const Color(0xffE5E5E5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirmText,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            prefixIcon: const Icon(Icons.lock_outline),
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
                            fillColor: const Color(0xffE5E5E5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color(0xFF0077B6),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                register();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00B4D8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text('Sign Up',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already Have an Account? ",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                splashColor: Colors.lightBlueAccent,
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Color(0xFF0077B6),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            'Or',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Sign Up With',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        ]),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              child: Container(
                                alignment: Alignment.bottomRight,
                                child: Image.asset(
                                  'images/signup_banner.png',
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 50,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(
                                            username: googleUserName,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          AssetImage('images/google_logo.png'),
                                    ),
                                  ),
                                  const SizedBox(width: 20),

                                  // Apple icon
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(
                                            username: appleUserName,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          AssetImage('images/apple_logo.png'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
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
