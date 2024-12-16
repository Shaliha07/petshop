import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shane_and_shawn_petshop/token_manager.dart';
import 'package:shane_and_shawn_petshop/under_construction_page.dart';
import 'bottom_navbar.dart';
import 'edit_profile_page.dart';
import 'contact_us_page.dart';
import 'login.dart';
import 'globals.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Map<String, dynamic>> appointmentHistories = [];
  List<Map<String, dynamic>> paymentHistories = [];

  @override
  void initState() {
    super.initState();
    fetchAppointmentHistories();
    fetchPaymentHistories();
  }

  String userName = '$globalUsername';

  Future<void> logout(BuildContext context) async {
    String? token = TokenManager.instance.accessToken;
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("No access token available. Please log in again."),
        backgroundColor: Colors.red,
      ));
      return;
    }

    String? localIp = dotenv.env['LOCAL_IP'];
    if (localIp == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Server URL not configured. Please try again later."),
        backgroundColor: Colors.red,
      ));
      return;
    }

    final url = Uri.parse('$localIp/auth/logout');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "username": "malith",
          "password": "1234",
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Logged out successfully."),
          backgroundColor: Colors.green,
        ));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        print('Failed to logout: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Logout failed: ${response.body}"),
          backgroundColor: Colors.red,
        ));
      }
    } catch (error) {
      print('Network Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("An error occurred: $error"),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> fetchAppointmentHistories() async {
    String? token = TokenManager.instance.accessToken;

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("No access token available. Please log in again."),
        backgroundColor: Colors.red,
      ));
      return;
    }

    Map<String, dynamic> payload = Jwt.parseJwt(token);
    print('Decoded JWT Payload: $payload');

    int? userId = payload['id'] ?? payload['userId'] ?? payload['sub'];
    print('User ID: $userId');

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Invalid token payload. User ID not found."),
        backgroundColor: Colors.red,
      ));
      return;
    }

    String? localIp = dotenv.env['LOCAL_IP'];
    if (localIp == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Server URL not configured. Please try again later."),
        backgroundColor: Colors.red,
      ));
      return;
    }

    final url = Uri.parse('$localIp/appointments/?userId=$userId');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Response Data: $responseData');
        if (responseData is Map && responseData['appointments'] is List) {
          setState(() {
            appointmentHistories = (responseData['appointments'] as List)
                .map((appointment) => {
                      'appointmentDate':
                          appointment['appointmentDate'].substring(0, 10),
                      'serviceName': getServiceName(appointment['serviceId']),
                      'additionalInformation':
                          appointment['additionalInformation'],
                      'status': appointment['status'] ? 'Completed' : 'Pending',
                    })
                .toList();
          });
        } else {
          print('Unexpected response structure: $responseData');
        }
      } else {
        print('Failed to fetch appointment histories: ${response.body}');
      }
    } catch (error) {
      print('Network Error: $error');
    }
  }

  Future<void> fetchPaymentHistories() async {
    String? token = TokenManager.instance.accessToken;
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("No access token available. Please log in again."),
        backgroundColor: Colors.red,
      ));
      return;
    }

    int? userId;
    try {
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      userId = payload['id'];
      if (userId == null) {
        throw Exception("User ID not found in token payload.");
      }
    } catch (e) {
      print("Error decoding token: $e");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Invalid token. Please log in again."),
        backgroundColor: Colors.red,
      ));
      return;
    }

    String? localIp = dotenv.env['LOCAL_IP'];
    if (localIp == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Server URL not configured. Please try again later."),
        backgroundColor: Colors.red,
      ));
      return;
    }

    final url = Uri.parse('$localIp/payment/?userId=$userId');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData is List) {
          setState(() {
            paymentHistories = responseData
                .where((payment) => payment['status'] == true)
                .map((payment) => {
                      'paymentDate': payment['paymentDate'].substring(0, 10),
                      'amount': payment['amount'],
                      'paymentMethod': payment['paymentMethod'],
                      'paymentStatus': payment['paymentStatus'],
                    })
                .toList();
          });
        } else {
          print('Unexpected response structure: $responseData');
        }
      } else {
        print('Failed to fetch payment histories: ${response.body}');
      }
    } catch (error) {
      print('Network Error: $error');
    }
  }

  String getServiceName(int serviceId) {
    switch (serviceId) {
      case 1:
        return "Health Checkup";
      case 2:
        return "Pet Training";
      case 3:
        return "Pet Grooming";
      default:
        return "Unknown Service";
    }
  }

  Widget buildAppointmentCard(Map<String, dynamic> appointment) {
    return Card(
      color: const Color(0xffECE6F0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${appointment['appointmentDate']}',
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
            Text(
              'Service: ${appointment['serviceName']}',
              style: const TextStyle(
                  color: Color(0xff65558F), fontWeight: FontWeight.w500),
            ),
            Text(
              'Additional Information: ${appointment['additionalInformation']}',
              style: const TextStyle(
                  color: Color(0xff65558F), fontWeight: FontWeight.w500),
            ),
            Text(
              'Status: ${appointment['status']}',
              style: const TextStyle(
                  color: Color(0xff65558F), fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentCard(Map<String, dynamic> payment) {
    return Card(
      color: const Color(0xffECE6F0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${payment['paymentDate']}',
              style: const TextStyle(fontWeight: FontWeight.w900),
            ),
            Text(
              'Amount: Rs.${payment['amount']}.00',
              style: const TextStyle(
                  color: Color(0xff65558F), fontWeight: FontWeight.w500),
            ),
            Text(
              'Payment Method: ${payment['paymentMethod']}',
              style: const TextStyle(
                  color: Color(0xff65558F), fontWeight: FontWeight.w500),
            ),
            Text('Payment Status: ${payment['paymentStatus']}',
                style: const TextStyle(
                    color: Color(0xff65558F), fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentMethodCard(
      String cardType, String cardNumber, String expiryDate) {
    return Card(
      color: const Color(0xffECE6F0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset('images/credit_card.png', height: 55),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Card Type: $cardType',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff65558F),
                  ),
                ),
                Text(
                  'Card Number: $cardNumber',
                  style: const TextStyle(
                    color: Color(0xff65558F),
                  ),
                ),
                Text(
                  'Expiry Date: $expiryDate',
                  style: const TextStyle(
                    color: Color(0xff65558F),
                  ),
                )
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_square),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UnderConstructionPage(),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UnderConstructionPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('images/user_avatar.png'),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Username',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 7),
                          decoration: BoxDecoration(
                            color: const Color(0xffECE6F0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            userName,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.mode_edit_outline_rounded),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfilePage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Appointment History",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                appointmentHistories.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: appointmentHistories.length,
                        itemBuilder: (context, index) {
                          return buildAppointmentCard(
                              appointmentHistories[index]);
                        },
                      ),
                const SizedBox(height: 20),
                const Text(
                  "Payment History",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                paymentHistories.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: paymentHistories.length,
                        itemBuilder: (context, index) {
                          return buildPaymentCard(paymentHistories[index]);
                        },
                      ),
                const SizedBox(height: 10),
                const Text(
                  "Payment Methods",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                buildPaymentMethodCard('Visa', '**** 1234', '06/25'),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UnderConstructionPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add_circle),
                    label: const Text('Add another method'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey[200],
                      side: const BorderSide(color: Colors.black),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () => logout(context),
                    icon: const Icon(Icons.logout_rounded),
                    label: const Text('Log Out'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      side: const BorderSide(color: Colors.black),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 144, vertical: 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 4),
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ContactUsPage(),
              ),
            );
          },
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Image.asset(
                'images/call_button.png',
                fit: BoxFit.cover,
                width: 60,
                height: 60,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
