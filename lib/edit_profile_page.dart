import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shane_and_shawn_petshop/token_manager.dart';
import 'profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    contactController.dispose();
    addressController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  Future<void> saveProfile() async {
    if (_formKey.currentState!.validate()) {
      String? token = TokenManager.instance.accessToken;

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('No access token available. Please log in again.'),
          backgroundColor: Colors.red,
        ));
        return;
      }

      // Decode the JWT to get the user ID
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      print('Decoded Payload: $payload');
      int userId = payload['id'];

      // Get user details
      String username = usernameController.text!;
      String email = emailController.text!;
      String contact = contactController.text!;
      String address = addressController.text!;
      String password = passwordController.text!;
      String firstName = firstNameController.text!;
      String lastName = lastNameController.text!;

      // Send a POST request to the server
      final url = Uri.parse('${dotenv.env['LOCAL_IP']}/users/$userId');
      try {
        final response = await http.put(url,
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
            body: jsonEncode({
              "username": username,
              "email": email,
              "password": password,
              "firstName": firstName,
              "lastName": lastName,
              "contactNumber": contact,
              "address": address,
            })); // Check if the response is successful
        if (response.statusCode == 200) {
          // Parse the response
          final responseData = jsonDecode(response.body);

          // Handle success, navigate to the home page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
        } else {
          // Handle error, show a message
          final responseData = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(responseData['message'] ?? 'Failed to save the user'),
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
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: 350,
              width: 900,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/gradient.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage('images/user_avatar.png'),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {},
                            child: const CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.edit,
                                size: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),
                    buildProfileTextField(
                      label: 'Username',
                      controller: usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username cannot be empty';
                        }
                        return null;
                      },
                    ),
                    buildProfileTextField(
                      label: 'First Name',
                      controller: firstNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'First Name cannot be empty';
                        }
                        return null;
                      },
                    ),
                    buildProfileTextField(
                      label: 'Last Name',
                      controller: lastNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Last Name cannot be empty';
                        }
                        return null;
                      },
                    ),
                    buildProfileTextField(
                      label: 'Password',
                      controller: passwordController,
                      validator: (value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null; // Allow empty passwords
                      },
                    ),
                    buildProfileTextField(
                      label: 'Email',
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email cannot be empty';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    buildProfileTextField(
                      label: 'Contact Number',
                      controller: contactController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Contact number cannot be empty';
                        }
                        if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                          return 'Enter a valid 10-digit contact number';
                        }
                        return null;
                      },
                    ),
                    buildProfileTextField(
                      label: 'Address',
                      controller: addressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Address cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            saveProfile();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffC6C6C6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 13),
                        ),
                        child: const Text(
                          'Save Profile',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.grey[900],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileTextField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffE5E5E5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
            controller: controller,
            validator: validator,
          ),
        ],
      ),
    );
  }
}
