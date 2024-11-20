import 'package:flutter/material.dart';
import 'package:shane_and_shawn_petshop/checkout_page.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  final String userAddress = '123 Main Street\nCity\nCountry';

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Flexible Joint',
      'quantity': 1,
      'price': 5500.00,
      'discount': 0.0,
    },
    {
      'name': 'Premium Dog Food',
      'quantity': 2,
      'price': 4500.00,
      'discount': 10.0,
    },
  ];

  final double deliveryFee = 260.00;

  double calculateTotal() {
    double total = 0;
    for (var product in products) {
      double price = product['price'];
      double discount = product['discount'];
      int quantity = product['quantity'];

      double discountedPrice = price - (price * discount / 100);
      total += discountedPrice * quantity;
    }
    total += deliveryFee;
    return total;
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = calculateTotal();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
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
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
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
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Billing & Summary',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Address card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: AddressCard(
                  address: userAddress,
                  onEdit: () {},
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 380,
                    height: 47,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(color: Colors.black),
                        color: Colors.white),
                    child: const Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Store Pickup",
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: products.map((product) {
                      double discountedPrice = product['price'] -
                          (product['price'] * product['discount'] / 100);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'x${product['quantity']}',
                            style: const TextStyle(fontSize: 14),
                          ),
                          if (product['discount'] > 0)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'LKR ${product['price'].toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  'LKR ${discountedPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            )
                          else
                            Text(
                              'LKR ${product['price'].toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          const SizedBox(height: 50),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Billing summary
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: BillingSummary(
                  itemsTotal: products.fold<int>(0, (int sum, product) {
                    return sum + (product['quantity'] as int);
                  }),
                  deliveryFee: deliveryFee,
                  total: totalPrice,
                ),
              ),

              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CheckoutPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xffE53B3B),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 13),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Confirm Payment'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  final String address;
  final VoidCallback onEdit;

  const AddressCard({required this.address, required this.onEdit, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              address,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }
}

class BillingSummary extends StatelessWidget {
  final int itemsTotal;
  final double deliveryFee;
  final double total;

  const BillingSummary({
    required this.itemsTotal,
    required this.deliveryFee,
    required this.total,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Summary',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Number of Items'),
            Text('$itemsTotal items'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Delivery Fee'),
            Text('LKR $deliveryFee'),
          ],
        ),
        const Divider(thickness: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'LKR ${total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
