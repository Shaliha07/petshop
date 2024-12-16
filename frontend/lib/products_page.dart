import 'dart:convert';
import 'package:flutter/material.dart';
import 'item_page.dart';
import 'bottom_navbar.dart';
import 'chatbot.dart';
import 'package:shane_and_shawn_petshop/token_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ProductsPage extends StatefulWidget {
  const ProductsPage({
    super.key,
    required this.selectedFilter,
  });
  final String selectedFilter;

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String category = '';
  @override
  void initState() {
    super.initState();
    fetchProducts();
    activeFilter = widget.selectedFilter;
    if (activeFilter == 'Food') {
      category = '3';
    } else if (activeFilter == 'Toys') {
      category = '2';
    } else if (activeFilter == 'Medicine') {
      category = '1';
    }

    if (category.isNotEmpty) {
      fetchProductsByCategory(category);
    }
  }

  bool categoryStatus = false;
  String activeFilter = 'All';
  final List<String> filters = ['All', 'Food', 'Toys', 'Medicine'];
  int currentIndex = 1;
  int gridViewCount = 3;
  String selectedSorting = 'Default';
  final List<String> sortingOptions = [
    'Default',
    'Order by Latest',
    'Price: Low to High',
    'Price: High to Low'
  ];

  bool isLoading = true;

  Future<void> fetchProducts() async {
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

    final url = Uri.parse('$localIp/products/');
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

        if (responseData is Map && responseData.containsKey('products')) {
          setState(() {
            products = (responseData['products'] as List<dynamic>)
                .map<Product>((product) {
              return Product.fromJson(product);
            }).toList();
          });
        } else {
          print('Unexpected response format');
        }
      } else {
        print('Failed to fetch products: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Failed to fetch products."),
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

  Future<void> fetchProductsByCategory(String categoryID) async {
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

    final url = Uri.parse('$localIp/products/categories/$categoryID/');
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
            products = (responseData['product'] as List<dynamic>)
                .map<Product>((product) => Product.fromJson(product))
                .toList();
          });
          print('Products fetched successfully: ${products.length}');
        } else {
          print('Unexpected response structure: $responseData');
        }
      } else {
        print('Failed to fetch products: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Failed to fetch products."),
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
                          backgroundColor: activeFilter == filter
                              ? const Color(0xFFC0C0C0)
                              : const Color(0xFFEFEFF0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () {
                          String categoryId;
                          switch (filter) {
                            case 'Food':
                              categoryId = '3';
                              break;
                            case 'Toys':
                              categoryId = '2';
                              break;
                            case 'Medicine':
                              categoryId = '1';
                              break;
                            default:
                              categoryId = '';
                              break;
                          }

                          if (categoryId.isNotEmpty) {
                            fetchProductsByCategory(categoryId);
                          } else {
                            fetchProducts();
                          }

                          setState(() {
                            activeFilter = filter;
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
                          switch (selectedSorting) {
                            case 'Default':
                              products.sort(
                                  (a, b) => a.productID.compareTo(b.productID));
                              break;
                            case 'Order by Latest':
                              products.sort(
                                  (a, b) => b.createdAt.compareTo(a.createdAt));
                              break;
                            case 'Price: Low to High':
                              products.sort((a, b) =>
                                  a.sellingPrice.compareTo(b.sellingPrice));
                              break;
                            case 'Price: High to Low':
                              products.sort((a, b) =>
                                  b.sellingPrice.compareTo(a.sellingPrice));
                              break;
                            default:
                              break;
                          }
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
              productPrice: product.sellingPrice,
              imageUrl: product.imageUrl,
              description: product.description,
              stockQty: product.stockQty,
              categoryId: product.categoryId,
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
                    'LKR ${product.sellingPrice.toStringAsFixed(2)}',
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
  final double sellingPrice;
  final String imageUrl;
  final String description;
  final int stockQty;
  final DateTime createdAt;
  final int categoryId;

  Product(
      {required this.productID,
      required this.name,
      required this.sellingPrice,
      required this.imageUrl,
      required this.description,
      required this.stockQty,
      required this.createdAt,
      required this.categoryId});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        productID: json['id'].toString(),
        name: json['productName'] ?? '',
        sellingPrice: (json['sellingPrice'] ?? 0).toDouble(),
        imageUrl: json['imageUrl'] ?? '',
        description: json['description'] ?? '',
        stockQty: json['stockQty'] ?? 0,
        createdAt: DateTime.parse(json['createdAt']),
        categoryId: json['categoryId'] ?? 0);
  }
}

List<Product> products = [];
