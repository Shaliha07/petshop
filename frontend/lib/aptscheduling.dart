import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shane_and_shawn_petshop/appointment.dart';
import 'package:shane_and_shawn_petshop/token_manager.dart';
import 'bottom_navbar.dart';
import 'package:http/http.dart' as http;

class SchedulingPage extends StatefulWidget {
  final String selectedDate;

  const SchedulingPage(
      {super.key,
      required this.selectedDate,
      required this.serviceName,
      required this.serviceID});
  final String serviceName;
  final int serviceID;

  @override
  State<SchedulingPage> createState() => _SchedulingPageState();
}

class _SchedulingPageState extends State<SchedulingPage> {
  final TextEditingController petTypeController = TextEditingController();
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController specialNotesController = TextEditingController();

  final String status = "success";

  @override
  void dispose() {
    petTypeController.dispose();
    petNameController.dispose();
    specialNotesController.dispose();
    super.dispose();
  }

  Future<void> createAppointment() async {
    String? token = TokenManager.instance.accessToken;
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No access token available. Please log in again."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Map<String, dynamic> payload = Jwt.parseJwt(token);
    print('Decoded JWT Payload: $payload');
    int userId = payload['id'];

    String? localIp = dotenv.env['LOCAL_IP'];
    if (localIp == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Server URL not configured. Please try again later."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final url = Uri.parse('$localIp/appointments/');

    String petType = petTypeController.text.trim();
    String petName = petNameController.text.trim();
    String additionalInformation = specialNotesController.text.trim();

    print("petType: ${petTypeController.text}");
    print("petName: ${petNameController.text}");
    print("additionalInformation: ${specialNotesController.text}");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          "userId": userId,
          "serviceId": widget.serviceID,
          "petType": petType,
          "petName": petName,
          "additionalInformation": additionalInformation,
          "appointmentDate": widget.selectedDate,
          "appointmentTime": "10:00 AM"
        }),
      );
      print("Request Body: $response");

      // Step 5: Handle Response
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Appointment created successfully: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Appointment created successfully!"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const AppointmentPage(
                  serviceName: 'Other Services', serviceID: 4)),
        );
      } else {
        print('Error Response: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonDecode(response.body)['message'] ??
              'Failed to create appointment.'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (error) {
      print('Network Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Network error occurred. Please try again later."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              top: 20,
              left: 10,
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
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xffECE6F0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Selected Date',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.selectedDate,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    buildTextField(
                      label: 'Pet Type',
                      controller: petTypeController,
                      focusNode: FocusNode(),
                    ),
                    const SizedBox(height: 10),
                    buildTextField(
                      label: 'Pet Name',
                      controller: petNameController,
                      focusNode: FocusNode(),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Appointment Type / Service',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 13),
                      decoration: BoxDecoration(
                        color: const Color(0xffECE6F0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 55,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.serviceName,
                            style: const TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    buildTextField(
                        label: 'Special Notes',
                        controller: specialNotesController,
                        focusNode: FocusNode(),
                        maxLines: 3),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffECE6F0),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Color(0xffE53B3B),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              createAppointment();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffECE6F0),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Confirm',
                              style: TextStyle(
                                  color: Color(0xff65558F), fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 3),
      ),
    );
  }

  Widget buildTextField(
      {required String label,
      required TextEditingController controller,
      int? maxLines,
      required FocusNode focusNode}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20),
            ),
            filled: true,
            fillColor: const Color(0xffECE6F0),
          ),
        ),
      ],
    );
  }
}
