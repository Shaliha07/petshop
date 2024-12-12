import 'package:flutter/material.dart';
import 'bottom_navbar.dart';
import 'chatbot.dart';
import 'products_page.dart';

class HomePage extends StatelessWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Welcome , $username !',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 11),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(
                    image: const AssetImage('images/paw_background.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      const Color.fromARGB(255, 154, 210, 255).withOpacity(0.2),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'UNIQUE PICKS TO ENTERTAIN YOUR\n',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.purple,
                                  height: 1.2,
                                ),
                              ),
                              TextSpan(
                                text: 'LOVED PET',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  color: Color.fromARGB(255, 202, 41, 29),
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          textAlign: TextAlign.right,
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'Everyday essentials and unique picks to\n',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                  height: 1.5,
                                ),
                              ),
                              TextSpan(
                                text: 'feed and pamper your pet',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 220,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductsPage(activeFilter: 'All'),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 122, 89, 171),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Text('CHECK IT NOW',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: -35,
                      left: 0,
                      child: Image.asset(
                        'images/cat_banner.png',
                        height: 160,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  padding: const EdgeInsets.all(25),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: <Widget>[
                    GestureDetector(
                      child: const IconItem(
                          title: 'Pet Toys', imagePath: 'images/pet_toys.png'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductsPage(activeFilter: 'Toys'),
                          ),
                        );
                      },
                    ),
                    GestureDetector(
                      child: const IconItem(
                          title: 'Pet Food', imagePath: 'images/pet_food.png'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductsPage(activeFilter: 'Food'),
                          ),
                        );
                      },
                    ),
                    GestureDetector(
                      child: const IconItem(
                          title: 'Pet Pharmacy',
                          imagePath: 'images/pet_pharmacy.png'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductsPage(activeFilter: 'Medicine'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductsPage(activeFilter: 'All'),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 5),
                      Expanded(
                        child: Image.asset(
                          'images/home_banner_brands.png',
                        ),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavBar(currentIndex: 0),
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
      ),
    );
  }
}

class IconItem extends StatefulWidget {
  final String title;
  final String imagePath;

  const IconItem({super.key, required this.title, required this.imagePath});

  @override
  _IconItemState createState() => _IconItemState();
}

class _IconItemState extends State<IconItem> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: Image.asset(widget.imagePath, height: 61),
          ),
          const SizedBox(height: 4),
          Text(
            widget.title,
            style: const TextStyle(fontSize: 11),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
