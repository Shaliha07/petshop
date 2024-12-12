import 'package:flutter/material.dart';
import 'package:shane_and_shawn_petshop/order_confirmation.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final String cardName = 'Max BOC';
  final String cardType = 'Visa';
  final String cardNumber = '**** **** **** 1234';
  final String cardExpiryDate = '08/26';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                    const SizedBox(height: 20),
                    const Text(
                      'Payment Methods',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 3),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'images/credit_card.png',
                                width: 100,
                                height: 100,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nickname: $cardName',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    'Card Type: $cardType',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    'Card Number: $cardNumber',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    'Expiry Date: $cardExpiryDate',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                            top: -10,
                            right: -5,
                            child: IconButton(
                              icon: Icon(Icons.edit_square,
                                  color: Colors.grey[800]),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add_circle),
                        label: const Text('Add another card'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.grey[200],
                          side: const BorderSide(
                              color: Colors.black), // Black border
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        'Or',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'images/payhere_logo.png',
                                width: 330,
                                height: 30,
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Bank Deposit',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Account Name: Shane & Shawn Vet',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Account Number: 72718189',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Branch: Kegalle 312',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.file_upload_outlined),
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
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OrderConfirmation(
                                isSuccess: true,
                                transactionNumber: "T12345678",
                                amountPaid: 5550.00,
                                paymentMethod: "Card Payment",
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 10),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text('Confirm Purchase'),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
