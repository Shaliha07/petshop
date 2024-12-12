import 'package:flutter/material.dart';
import 'package:shane_and_shawn_petshop/contact_us_page.dart';
import 'package:shane_and_shawn_petshop/edit_profile_page.dart';
import 'bottom_navbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  final String userName = 'John';

  final int paymentID = 0001;
  final String paymentDate = 'August 25, 2023';
  final double paidAmount = 3232.00;
  final String paidService = 'Purchase of "Rabies Shot"';
  final String paymentMethod = 'Credit Card';
  final String paymentStatus = 'Paid';

  

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
                  buildSectionTitle('Appointment History'),
                  buildExpandableHistoryCard(
                      'April 5, 2024',
                      'Time: 11:00 AM\nService: Rabies Vaccination\nLocation: Pet Clinic\nNotes: Regular check-up and Rabies shot administered.',
                      'Follow-up appointment scheduled for April 15, 2024. No adverse reactions observed.'),
                  buildSectionTitle('Payment History'),
                  buildPaymentHistoryCard(paymentDate,
                      'Amount: $paidAmount LKR\nService: $paidService\nPayment Method: $paymentMethod\n'),
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
      color: const Color(0xffECE6F0),
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          summary,
          style: const TextStyle(color: Color(0xff65558F)),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              details,
              style: const TextStyle(color: Color(0xff65558F)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPaymentHistoryCard(String date, String description) {
    return Card(
      color: const Color(0xffECE6F0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(description, style: const TextStyle(color: Color(0xff65558F))),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.receipt_long_sharp),
                    label: const Text('View Receipt'),
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
                Text('Card Type: $cardType',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff65558F))),
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
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
