import 'package:flutter/material.dart';
import 'cart_page.dart';
import 'bottom_navbar.dart';
import 'chatbot.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shane_and_shawn_petshop/token_manager.dart';

class ItemPage extends StatefulWidget {
  final String productID;
  final String productName;
  final String imageUrl;
  final double productPrice;
  final String description;
  final int stockQty;
  final int categoryId;

  const ItemPage({
    super.key,
    required this.productID,
    required this.productName,
    required this.productPrice,
    required this.imageUrl,
    required this.description,
    required this.stockQty,
    required this.categoryId,
  });

  @override
  _ItemPageState createState() => _ItemPageState();
}

class Product {
  final int id;
  final int categoryId;
  final String productName;
  final String description;
  final int stockQty;
  final double purchasingPrice;
  final double sellingPrice;
  final String imageUrl;
  final bool status;

  Product({
    required this.id,
    required this.categoryId,
    required this.productName,
    required this.description,
    required this.stockQty,
    required this.purchasingPrice,
    required this.sellingPrice,
    required this.imageUrl,
    required this.status,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      categoryId: json['categoryId'],
      productName: json['productName'],
      description: json['description'],
      stockQty: json['stockQty'],
      purchasingPrice: json['purchasingPrice'].toDouble(),
      sellingPrice: json['sellingPrice'].toDouble(),
      imageUrl: json['imageUrl'],
      status: json['status'],
    );
  }
}

class _ItemPageState extends State<ItemPage> {
  List<Product> similarProducts = [];
  bool isLoading = false;

  Future<void> fetchProductsByCategory(String categoryId) async {
    String? token = TokenManager.instance.accessToken;
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("No access token available. Please log in again."),
        backgroundColor: Colors.red,
      ));
      return;
    }

    String? localIp = dotenv.env['LOCAL_IP'];
    if (localIp == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Server URL not configured. Please try again later."),
        backgroundColor: Colors.red,
      ));
      return;
    }

    final url = Uri.parse('$localIp/products/categories/$categoryId/');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData is Map && responseData.containsKey('product')) {
          setState(() {
            similarProducts = (responseData['product'] as List<dynamic>)
                .map<Product>((product) => Product.fromJson(product))
                .toList();
          });
          print('Products fetched successfully: ${similarProducts.length}');
        } else {
          print('Unexpected response structure: $responseData');
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text("Unexpected server response. Please try again later."),
            backgroundColor: Colors.red,
          ));
        }
      } else {
        print('Failed to fetch products: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to fetch products: ${response.reasonPhrase}"),
          backgroundColor: Colors.red,
        ));
      }
    } catch (error) {
      print('Network Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred: $error'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProductsByCategory(widget.categoryId.toString());
  }

  int quantity = 1;
  bool isFavorite = false;

  String categoryName = 'Medicine';
  int categoryID = 1;
  bool status = false;

  @override
  Widget build(BuildContext context) {
    if (widget.categoryId == 1) {
      categoryName = "Medicine";
    } else if (widget.categoryId == 2) {
      categoryName = "Toys";
    } else if (widget.categoryId == 3) {
      categoryName = "Pet Food";
    } else {
      categoryName = "Other";
    }

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                  child: Image.asset(
                    widget.imageUrl,
                    width: 380,
                    height: 380,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productName,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'LKR ${widget.productPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          '${widget.stockQty} in Stock',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              buildQuantityAndCartButton(),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  widget.description,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SKU: ${widget.productID}',
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Categories: $categoryName',
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              buildSimilarProducts(),
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

  Widget buildQuantityAndCartButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (quantity > 1) {
                        quantity--;
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(8),
                      ),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(
                        '-',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    quantity.toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(
                      () {
                        quantity++;
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(8)),
                    ),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(
                        '+',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(
                    imageUrl: widget.imageUrl,
                    productID: widget.productID,
                    productName: widget.productName,
                    productPrice: widget.productPrice,
                    stockQty: widget.stockQty,
                    quantity: quantity,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xff2AE311),
              padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 10),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text('Add to Cart'),
          ),
          const SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () {
              setState(
                () {
                  isFavorite = !isFavorite;
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSimilarProducts() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Similar Products',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : similarProducts.isEmpty
                  ? const Text('No similar products available.')
                  : SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: similarProducts.length,
                        itemBuilder: (context, index) {
                          final product = similarProducts[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemPage(
                                    productID: product.id.toString(),
                                    productName: product.productName,
                                    productPrice: product.sellingPrice,
                                    imageUrl: product.imageUrl,
                                    description: product.description,
                                    stockQty: product.stockQty,
                                    categoryId: product.categoryId,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Column(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Image.asset(
                                      product.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    product.productName,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}
