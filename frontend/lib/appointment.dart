import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'aptscheduling.dart';
import 'chatbot.dart';
import 'bottom_navbar.dart';

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
                    child: const Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 40,
                          color: Colors.black,
                        ),
                        SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Open Hours',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Everyday from 09:00 - 20:30',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Open Now',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green,
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
                              DateFormat('EEE, MMM d').format(selectedDate),
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
                          firstDate: DateTime(2000),
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
                                      selectedDate: DateFormat('EEE, MMM d')
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
                Card(
                  color: const Color.fromARGB(255, 236, 230, 240),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Row(
                      children: [
                        Text(
                          'No Appointments Scheduled',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
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
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
