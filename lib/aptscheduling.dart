import 'package:flutter/material.dart';
import 'bottom_navbar.dart';

class SchedulingPage extends StatelessWidget {
  final String selectedDate;

  const SchedulingPage({super.key, required this.selectedDate});

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
                        color: const Color.fromARGB(255, 236, 230, 240),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.purple[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Selected Date',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              selectedDate,
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    buildTextField(label: 'Pet Type'),
                    const SizedBox(height: 10),
                    buildTextField(label: 'Pet Name'),
                    const SizedBox(height: 10),
                    buildTextField(label: 'Appointment Type / Service'),
                    const SizedBox(height: 10),
                    buildTextField(label: 'Special Notes', maxLines: 3),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple[50],
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple[50],
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'Confirm',
                              style: TextStyle(
                                  color: Colors.purple[150], fontSize: 14),
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

  Widget buildTextField({required String label, int? maxLines}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        const SizedBox(height: 5),
        TextField(
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.purple[200]!),
            ),
            filled: true,
            fillColor: const Color.fromARGB(255, 236, 230, 240),
          ),
        ),
      ],
    );
  }
}
