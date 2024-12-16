import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shane_and_shawn_petshop/token_manager.dart';
import 'package:shane_and_shawn_petshop/under_construction_page.dart';
import 'profile_page.dart';
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

  bool _isPasswordVisible = false;

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

      print('Access Token: $token');

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No access token available. Please log in again.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      Map<String, dynamic> payload = Jwt.parseJwt(token);
      print('Decoded JWT Payload: $payload');
      int userId = payload['id'];

      String username = usernameController.text.trim();
      String email = emailController.text.trim();
      String contact = contactController.text.trim();
      String address = addressController.text.trim();
      String password = passwordController.text.trim();
      String firstName = firstNameController.text.trim();
      String lastName = lastNameController.text.trim();

      print('Form Values:');
      print('Username: $username');
      print('First Name: $firstName');
      print('Last Name: $lastName');
      print('Email: $email');
      print('Contact: $contact');
      print('Address: $address');

      String? localIp;
      try {
        localIp = dotenv.env['LOCAL_IP'];
      } catch (error) {
        print('Error loading LOCAL_IP from .env: $error');
      }

      if (localIp == null) {
        print('Error: LOCAL_IP is not set in .env file.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Server URL not configured. Please try again later.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final url = Uri.parse('$localIp/users/$userId');

      print('API URL: $url');
      print('Request Payload: ${{
        "username": username,
        "email": email,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
        "contactNumber": contact,
        "address": address,
      }}');

      try {
        final response = await http.put(
          url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
          body: jsonEncode(
            {
              "username": username,
              "email": email,
              "password": password,
              "firstName": firstName,
              "lastName": lastName,
              "contactNumber": contact,
              "address": address,
            },
          ),
        );

        print('Response Status: ${response.statusCode}');
        print('Response Body: ${response.body}');

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);

          print('Profile updated successfully: $responseData');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProfilePage()),
          );
        } else {
          final responseData = jsonDecode(response.body);
          print('Server Error: $responseData');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text(responseData['message'] ?? 'Failed to save the user'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (error) {
        print("Error occurred during API request: $error");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred. Please try again later.'),
            backgroundColor: Colors.red,
          ),
        );
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const UnderConstructionPage(),
                                ),
                              );
                            },
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
                        return null;
                      },
                      isPassword: true,
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
    bool isPassword = false,
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
            obscureText: isPassword && !_isPasswordVisible,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffE5E5E5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              suffixIcon: isPassword
                  ? IconButton(
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
                    )
                  : null,
            ),
            controller: controller,
            validator: validator,
          ),
        ],
      ),
    );
  }
}
