import 'package:flutter/material.dart';
import 'package:shane_and_shawn_petshop/contact_us_page.dart';
import 'package:shane_and_shawn_petshop/edit_profile_page.dart';
import 'bottom_navbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
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
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('images/user_avatar.png'),
                      ),
                      const SizedBox(width: 20),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Username',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Max',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.edit_square),
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
                    'Pets',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    color: Colors.purple[50],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage('images/dog_profile.png'),
                          ),
                          const SizedBox(width: 20),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Pet Name: Roxy',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text('Species: Dog',
                                  style: TextStyle(color: Colors.black54)),
                              Text('Age: 4 Years Old',
                                  style: TextStyle(color: Colors.black54)),
                              Text('Breed: Siberian Husky',
                                  style: TextStyle(color: Colors.black54)),
                              Text('Birthday: April 12, 2020',
                                  style: TextStyle(color: Colors.black54)),
                              Text('Microchip: 123-456-789',
                                  style: TextStyle(color: Colors.black54)),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_square),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add_circle),
                      label: const Text('Add another pet'),
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
                  buildSectionTitle('Medical History'),
                  buildExpandableHistoryCard(
                      'Rabies Vaccination',
                      'Date: March 15, 2023\nType: 1 Year Rabies Vaccine\nManufacturer: IMRAB 3',
                      'Detailed information about the rabies vaccination, including side effects and follow-up recommendations.'),
                  buildExpandableHistoryCard(
                      'Apoquel (Medication)',
                      'Purpose: Allergy relief\nDosage: 4.5 mg, once daily\nStart Date: August 1, 2024\nEnd Date: Ongoing',
                      'Apoquel is used to manage allergy symptoms in pets. It is administered daily and monitored for any side effects.'),
                  buildSectionTitle('Appointment History'),
                  buildExpandableHistoryCard(
                      'April 5, 2024',
                      'Time: 11:00 AM\nService: Rabies Vaccination\nLocation: Pet Clinic\nNotes: Regular check-up and Rabies shot administered.',
                      'Follow-up appointment scheduled for April 15, 2024. No adverse reactions observed.'),
                  buildSectionTitle('Payment History'),
                  buildPaymentHistoryCard('August 25, 2023',
                      'Amount: 3,232 LKR\nService: Purchase of "Rabies Shot"\nPayment Method: Credit Card\n'),
                  const SizedBox(height: 10),
                  buildSectionTitle('Payment Methods'),
                  buildPaymentMethodCard('Visa', '**** 1234', '06/25'),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {},
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
                ],
              ),
            ),
          ],
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

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildExpandableHistoryCard(
      String title, String summary, String details) {
    return Card(
      color: Colors.purple[50],
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          summary,
          style: const TextStyle(color: Colors.black54),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              details,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPaymentHistoryCard(String date, String description) {
    return Card(
      color: Colors.purple[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(description, style: const TextStyle(color: Colors.black54)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.receipt_long_sharp),
                    label: const Text('Upload Receipt'),
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
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentMethodCard(
      String cardType, String cardNumber, String expiryDate) {
    return Card(
      color: Colors.purple[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset('images/credit_card.png', width: 60),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Card Type: $cardType',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('Card Number: $cardNumber',
                    style: const TextStyle(color: Colors.black54)),
                Text('Expiry Date: $expiryDate',
                    style: const TextStyle(color: Colors.black54)),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.edit_square),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
