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

  final int userID = 1;
  final String password = "1234";
  final String firstName = "John";
  final String lastName = "Doe";
  final String role = "user";
  final String status = "online";

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
                      label: 'Username', controller: usernameController),
                  buildProfileTextField(
                      label: 'Email', controller: emailController),
                  buildProfileTextField(
                      label: 'Contact Number', controller: contactController),
                  buildProfileTextField(
                      label: 'Address', controller: addressController),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Text('Username: ${usernameController.text}');
                        Text('Email: ${emailController.text}');
                        Text('Contact: ${contactController.text}');
                        Text('Address: ${addressController.text}');
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
              fillColor: const Color(0xffE5E5E5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
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
