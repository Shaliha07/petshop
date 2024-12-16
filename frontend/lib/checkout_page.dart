import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shane_and_shawn_petshop/order_confirmation.dart';
import 'package:shane_and_shawn_petshop/profile_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shane_and_shawn_petshop/token_manager.dart';
import 'package:shane_and_shawn_petshop/under_construction_page.dart';

class CheckoutPage extends StatefulWidget {
  final double total;
  final int quantity;
  final double productPrice;
  final double discount;
  final String productId;
  final String productName;
  const CheckoutPage(
      {super.key,
      required this.total,
      required this.quantity,
      required this.productPrice,
      required this.discount,
      required this.productId,
      required this.productName});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final String cardName = 'Max BOC';
  final String cardType = 'Visa';
  final String cardNumber = '**** **** **** 1234';
  final String cardExpiryDate = '08/26';

  String selectedPaymentMethod = "Credit Card";

  void _selectPaymentMethod(String method) {
    setState(() {
      selectedPaymentMethod = method;
    });
  }

  bool isLoading = false;
  Future<void> addTransaction() async {
    setState(() {
      isLoading = true;
    });

    String? token = TokenManager.instance.accessToken;

    print('Access Token: $token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No access token available. Please log in again.'),
        backgroundColor: Colors.red,
      ));
      setState(() {
        isLoading = false;
      });
      return;
    }

    Map<String, dynamic> payload = Jwt.parseJwt(token);
    print('Decoded JWT Payload: $payload');
    int userId = payload['id'];

    String currentDate = DateTime.now().toIso8601String().substring(0, 10);

    String? localIp = dotenv.env['LOCAL_IP'];

    if (localIp == null) {
      print('Error: LOCAL_IP is not set in .env file.');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Server URL not configured. Please try again later.'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    final url = Uri.parse('$localIp/transactions/');

    print('API URL: $url');
    print('Request Payload: ${{
      "userId": userId,
      "date": currentDate,
      "tax": 0,
      "discount": widget.discount,
      "amountPaid": widget.total,
      "paymentMethod": selectedPaymentMethod,
      "items": [
        {
          "productId": widget.productId,
          "quantity": widget.quantity,
          "price": widget.productPrice
        }
      ]
    }}');

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "userId": userId,
          "date": currentDate,
          "tax": 0,
          "discount": widget.discount,
          "amountPaid": widget.total,
          "paymentMethod": selectedPaymentMethod,
          "items": [
            {
              "productId": widget.productId,
              "quantity": widget.quantity,
              "price": widget.productPrice
            }
          ]
        }),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);

        print('Transaction saved successfully: $responseData');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OrderConfirmation(
              isSuccess: true,
              amountPaid: widget.total,
              paymentMethod: selectedPaymentMethod,
              quantity: widget.quantity,
              productId: widget.productId,
              productPrice: widget.productPrice,
              discount: widget.discount,
              productName: widget.productName,
            ),
          ),
        );
      } else {
        final responseData = jsonDecode(response.body);
        print('Server Error: $responseData');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                responseData['message'] ?? 'Failed to save the transaction'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      print("Error occurred during API request: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again later.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(
        () {
          isLoading = false;
        },
      );
    }
  }

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
                    Stack(
                      children: [
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
                          child: Row(
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
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Checkbox(
                            value: selectedPaymentMethod == "Credit Card",
                            onChanged: (value) {
                              _selectPaymentMethod("Credit Card");
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfilePage(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add_circle),
                        label: const Text('Add another card'),
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
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        'Or',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _selectPaymentMethod("PayHere");
                          },
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
                        Positioned(
                          right: 10,
                          child: Checkbox(
                            value: selectedPaymentMethod == "PayHere",
                            onChanged: (value) {
                              _selectPaymentMethod("PayHere");
                            },
                          ),
                        ),
                      ],
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
                    Stack(
                      children: [
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
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Checkbox(
                            value: selectedPaymentMethod == "Cash",
                            onChanged: (value) {
                              _selectPaymentMethod("Cash");
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const UnderConstructionPage(),
                            ),
                          );
                        },
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
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () async {
                                await addTransaction();
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
