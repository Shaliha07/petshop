import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shane_and_shawn_petshop/token_manager.dart';
import 'aptscheduling.dart';
import 'chatbot.dart';
import 'bottom_navbar.dart';
import 'package:http/http.dart' as http;

class AppointmentPage extends StatefulWidget {
  const AppointmentPage(
      {super.key, required this.serviceName, required this.serviceID});
  final String serviceName;
  final int serviceID;

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  DateTime selectedDate = DateTime.now();
  List<Map<String, dynamic>> appointmentHistories = [];
  @override
  void initState() {
    super.initState();
    fetchAppointmentHistories();
  }

  bool _isOpenNow() {
    final now = DateTime.now();
    const openTime = TimeOfDay(hour: 9, minute: 0);
    const closeTime = TimeOfDay(hour: 20, minute: 30);

    final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);

    if ((currentTime.hour > openTime.hour ||
            (currentTime.hour == openTime.hour &&
                currentTime.minute >= openTime.minute)) &&
        (currentTime.hour < closeTime.hour ||
            (currentTime.hour == closeTime.hour &&
                currentTime.minute <= closeTime.minute))) {
      return true;
    }
    return false;
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

    int? userId;
    try {
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      userId = payload['id']; // Ensure 'id' is part of the payload
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

        if (responseData is Map && responseData['appointments'] is List) {
          DateTime now = DateTime.now();
          setState(() {
            appointmentHistories = (responseData['appointments'] as List)
                .where((appointment) {
                  try {
                    DateTime date =
                        DateTime.parse(appointment['appointmentDate']);
                    TimeOfDay time = TimeOfDay(
                      hour: int.parse(
                          appointment['appointmentTime'].split(':')[0]),
                      minute: int.parse(
                          appointment['appointmentTime'].split(':')[1]),
                    );

                    DateTime appointmentDateTime = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      time.hour,
                      time.minute,
                    );

                    return appointmentDateTime.isAfter(now);
                  } catch (e) {
                    print('Error parsing appointment date/time: $e');
                    return false;
                  }
                })
                .map((appointment) => {
                      'appointmentDate':
                          appointment['appointmentDate'].substring(0, 10),
                      'appointmentTime': appointment['appointmentTime'],
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 9.0, vertical: 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xffF1F1F1),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 40,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Open Hours',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Everyday from 09:00 - 20:30',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              _isOpenNow() ? 'Open Now' : 'Closed',
                              style: TextStyle(
                                fontSize: 14,
                                color: _isOpenNow() ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const Text('Select date',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                const SizedBox(height: 10),
                Card(
                  color: const Color(0xffECE6F0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('yyyy-MM-dd').format(selectedDate),
                              style: const TextStyle(
                                  fontSize: 22, color: Colors.black87),
                            ),
                            IconButton(
                              icon:
                                  const Icon(Icons.edit, color: Colors.black54),
                              onPressed: () {
                                _selectDate(context);
                              },
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                        CalendarDatePicker(
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          onDateChanged: (date) {
                            setState(() {
                              selectedDate = date;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedDate = DateTime.now();
                                });
                              },
                              child: const Text('Clear',
                                  style: TextStyle(color: Colors.purple)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SchedulingPage(
                                      serviceID: widget.serviceID,
                                      serviceName: widget.serviceName,
                                      selectedDate: DateFormat('yyyy-MM-dd')
                                          .format(selectedDate),
                                    ),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 35, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: const BorderSide(color: Colors.purple),
                                ),
                              ),
                              child: const Text(
                                'Add an Appointment',
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Current Appointments',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity, // or any desired size
                  height: 0 + (appointmentHistories.length * 200),
                  child: ClipRect(
                    child: appointmentHistories.isEmpty
                        ? Center(
                            child: Card(
                              color: const Color.fromARGB(255, 236, 230, 240),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(40.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'No Appointments Scheduled',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: appointmentHistories.length,
                            itemBuilder: (context, index) {
                              final appointment = appointmentHistories[index];
                              return Card(
                                margin: const EdgeInsets.all(8.0),
                                color: const Color.fromARGB(255, 236, 230, 240),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Service: ${appointment['serviceName']}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Date: ${appointment['appointmentDate']}",
                                        style: const TextStyle(
                                            color: Color(0xff65558F),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "Time: ${appointment['appointmentTime']}",
                                        style: const TextStyle(
                                            color: Color(0xff65558F),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "Info: ${appointment['additionalInformation'] ?? 'N/A'}",
                                        style: const TextStyle(
                                            color: Color(0xff65558F),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "Status: ${appointment['status']}",
                                        style: const TextStyle(
                                            color: Color(0xff65558F),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 3),
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChatBotPage(),
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
                'images/chatbot.png',
                fit: BoxFit.cover,
                width: 70,
                height: 70,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
