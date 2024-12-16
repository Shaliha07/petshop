import 'package:flutter/material.dart';
import 'package:shane_and_shawn_petshop/products_page.dart';
import 'package:shane_and_shawn_petshop/summary_page.dart';

class OrderConfirmation extends StatelessWidget {
  final bool isSuccess;

  final double amountPaid;
  final String paymentMethod;
  final int quantity;
  final double productPrice;
  final double discount;
  final String productId;
  final String productName;

  const OrderConfirmation({
    super.key,
    required this.isSuccess,
    required this.amountPaid,
    required this.paymentMethod,
    required this.quantity,
    required this.productPrice,
    required this.discount,
    required this.productId,
    required this.productName,
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
                      'Rs.${amountPaid.toStringAsFixed(2)}',
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
                      'Paid by ',
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
                    if (isSuccess) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ProductsPage(selectedFilter: "All")),
                        (route) => false,
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SummaryPage(
                                  quantity: quantity,
                                  productPrice: productPrice,
                                  productId: productId,
                                  discount: discount,
                                  productName: productName,
                                )),
                      );
                    }
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
