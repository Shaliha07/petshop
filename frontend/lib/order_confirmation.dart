import 'package:flutter/material.dart';

class OrderConfirmation extends StatelessWidget {
  final bool isSuccess;
  final String transactionNumber;
  final double amountPaid;
  final String paymentMethod;

  const OrderConfirmation({
    super.key,
    required this.isSuccess,
    required this.transactionNumber,
    required this.amountPaid,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSuccess ? Colors.green[100] : Colors.red[100],
                  ),
                  child: Icon(
                    isSuccess ? Icons.check : Icons.close,
                    size: 60,
                    color: isSuccess ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  isSuccess ? 'Payment Successful' : 'Payment Failed',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Transaction Number: $transactionNumber',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Payment Amount ',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Rs.$amountPaid',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Payed by ',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      paymentMethod,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSuccess ? Colors.green : Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    isSuccess ? 'Go Back' : 'Retry Payment',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
