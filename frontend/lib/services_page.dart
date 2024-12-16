import 'package:flutter/material.dart';
import 'package:shane_and_shawn_petshop/appointment.dart';
import 'bottom_navbar.dart';
import 'chatbot.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  int currentIndex = 2;
  int serviceID = 4;
  String serviceName = "Other Service";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Search Bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                const SizedBox(height: 10),
                // Services Section
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 150,
                      child: GestureDetector(
                        child: const Image(
                          image: AssetImage('images/service1.png'),
                          fit: BoxFit.cover,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AppointmentPage(
                                serviceID: 1,
                                serviceName: "Health Checkup",
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: GestureDetector(
                          child: const Image(
                            image: AssetImage('images/service2.png'),
                            fit: BoxFit.cover,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AppointmentPage(
                                  serviceID: 1,
                                  serviceName: "Health Checkup",
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 180,
                      child: GestureDetector(
                          child: const Image(
                            image: AssetImage('images/service3.png'),
                            fit: BoxFit.cover,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AppointmentPage(
                                  serviceID: 1,
                                  serviceName: "Health Checkup",
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 158,
                      child: GestureDetector(
                          child: const Image(
                            image: AssetImage('images/service4.png'),
                            fit: BoxFit.cover,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AppointmentPage(
                                  serviceID: 1,
                                  serviceName: "Health Checkup",
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 150,
                      child: GestureDetector(
                          child: const Image(
                            image: AssetImage('images/service5.png'),
                            fit: BoxFit.cover,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AppointmentPage(
                                  serviceID: 1,
                                  serviceName: "Health Checkup",
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 150,
                      child: GestureDetector(
                          child: const Image(
                            image: AssetImage('images/service6.png'),
                            fit: BoxFit.cover,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AppointmentPage(
                                  serviceID: 2,
                                  serviceName: "Pet Training",
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 165,
                      child: GestureDetector(
                          child: const Image(
                            image: AssetImage('images/service7.png'),
                            fit: BoxFit.cover,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AppointmentPage(
                                  serviceID: 2,
                                  serviceName: "Pet Training",
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 150,
                      child: GestureDetector(
                        child: const Image(
                          image: AssetImage('images/service8.png'),
                          fit: BoxFit.cover,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AppointmentPage(
                                serviceID: 2,
                                serviceName: "Pet Training",
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: GestureDetector(
                        child: const Image(
                          image: AssetImage('images/service9.png'),
                          fit: BoxFit.cover,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AppointmentPage(
                                serviceID: 3,
                                serviceName: "Pet Grooming",
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      child: GestureDetector(
                        child: const Image(
                          image: AssetImage('images/service10.png'),
                          fit: BoxFit.cover,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AppointmentPage(
                                serviceID: 3,
                                serviceName: "Pet Grooming",
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
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
    );
  }

  Widget serviceCard(String title, String iconPath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple[800],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              iconPath,
              width: 60,
              height: 60,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
