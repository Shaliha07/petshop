import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController usernameController =
      TextEditingController(text: 'Max');
  final TextEditingController emailController =
      TextEditingController(text: 'max@gmail.com');
  final TextEditingController contactController =
      TextEditingController(text: '037 234 5678');
  final TextEditingController addressController =
      TextEditingController(text: 'No. 48, Main Street, Kurunegala');

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    contactController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.red, Colors.blue, Colors.purple],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('images/user_avatar.png'),
                      ),
                      const Positioned(
                        bottom: 10,
                        right: 140,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.edit, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  buildProfileTextField(
                      label: 'Username', controller: usernameController),
                  buildProfileTextField(
                      label: 'Email', controller: emailController),
                  buildProfileTextField(
                      label: 'Contact Number', controller: contactController),
                  buildProfileTextField(
                      label: 'Address', controller: addressController),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      print('Username: ${usernameController.text}');
                      print('Email: ${emailController.text}');
                      print('Contact: ${contactController.text}');
                      print('Address: ${addressController.text}');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[700],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 15),
                    ),
                    child: const Text(
                      'Save Profile',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            // Custom Back Button
            Positioned(
              top: 40,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileTextField(
      {required String label, required TextEditingController controller}) {
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
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
            ),
            controller: controller,
          ),
        ],
      ),
    );
  }
}
