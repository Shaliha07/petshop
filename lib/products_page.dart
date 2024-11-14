import 'package:flutter/material.dart';
import 'item_page.dart';
import 'bottom_navbar.dart';
import 'chatbot.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({super.key, required this.activeFilter});
  String activeFilter = 'All';

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  int categoryID = 1;
  String categoryName = 'Medicine';
  bool categoryStatus = false;

  final List<String> filters = ['All', 'Food', 'Toys', 'Treats', 'Medicine'];
  int currentIndex = 1;
  int gridViewCount = 3;
  String selectedSorting = 'Default';
  final List<String> sortingOptions = [
    'Default',
    'Order by Latest',
    'Price: Low to High',
    'Price: High to Low'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: filters.map((filter) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.activeFilter == filter
                              ? const Color(0xFFC0C0C0)
                              : const Color(0xFFEFEFF0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            widget.activeFilter = filter;
                          });
                        },
                        child: Text(
                          filter,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.grid_view),
                        onPressed: () {
                          setState(() {
                            gridViewCount = 3;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.grid_3x3),
                        onPressed: () {
                          setState(() {
                            gridViewCount = 2;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.list),
                        onPressed: () {
                          setState(() {
                            gridViewCount = 1;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 200,
                    child: DropdownButtonFormField<String>(
                      value: selectedSorting,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2.0),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      dropdownColor: Colors.white,
                      icon: Icon(Icons.arrow_drop_down_circle,
                          color: Colors.grey[800]),
                      items: sortingOptions.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSorting = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridViewCount,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: products[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
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
}

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemPage(
              productID: product.productID,
              productName: product.name,
              productPrice: product.price,
              imageUrl: product.imageUrl,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(product.imageUrl),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'LKR ${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final String productID;
  final String name;
  final double price;
  final String imageUrl;

  Product(
      {required this.productID,
      required this.name,
      required this.price,
      required this.imageUrl});
}

final List<Product> products = [
  Product(
      productID: '001',
      name: 'Flexible Joint',
      price: 5550.00,
      imageUrl: 'images/product.jpg'),
  Product(
      productID: '002',
      name: 'Cat Toy',
      price: 3322.00,
      imageUrl: 'images/product.jpg'),
  Product(
      productID: '003',
      name: 'Dog Treats',
      price: 3300.00,
      imageUrl: 'images/product.jpg'),
  Product(
      productID: '004',
      name: 'Flexible Joint',
      price: 1500.00,
      imageUrl: 'images/product.jpg'),
  Product(
      productID: '005',
      name: 'Dog Medicine',
      price: 2200.00,
      imageUrl: 'images/product.jpg'),
  Product(
      productID: '006',
      name: 'Cat Treats',
      price: 1300.00,
      imageUrl: 'images/product.jpg'),
];
