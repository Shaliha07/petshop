import 'package:flutter/material.dart';
import 'bottom_navbar.dart'; // Import the chatbot page
import 'chatbot.dart';

class HomePage extends StatelessWidget {
  final String username;

  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Welcome , $username !', // Use the username here
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
                margin: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(
                    image: AssetImage('images/background with paw.png'),
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
                        // Text with two lines and different font sizes
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
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
                                  color: const Color.fromARGB(255, 202, 41, 29),
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        RichText(
                          textAlign: TextAlign.right,
                          text: TextSpan(
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
                        SizedBox(height: 15),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 122, 89, 171),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text('CHECK IT NOW',
                                    style: TextStyle(color: Colors.white)),
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
                        'images/Banner Cat.png',
                        height: 160,
                      ),
                    ),
                  ],
                ),
              ),
              // Grid of pet-related items
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  padding: EdgeInsets.all(25),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: <Widget>[
                    IconItem(
                        title: 'Pet Toys', imagePath: 'images/Tennis Ball.png'),
                    IconItem(
                        title: 'Pet Food', imagePath: 'images/Pet Bone.png'),
                    IconItem(
                        title: 'Pet Treats', imagePath: 'images/Dog Bowl.png'),
                    IconItem(
                        title: 'Pet Pharmacy',
                        imagePath: 'images/Insulin Pen.png'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 5),
                    // Rectangle image
                    Expanded(
                      child: Image.asset(
                        'images/Rectangle 3780.png',
                      ),
                    ),
                    // SizedBox with minimal width to reduce the space
                    SizedBox(width: 5),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(currentIndex: 0),
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ChatBotPage(),
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

// Stateful widget for icon items
class IconItem extends StatefulWidget {
  final String title;
  final String imagePath;

  const IconItem({Key? key, required this.title, required this.imagePath})
      : super(key: key);

  @override
  _IconItemState createState() => _IconItemState();
}

class _IconItemState extends State<IconItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Center(
            child: Image.asset(widget.imagePath, height: 61),
          ),
          SizedBox(height: 4),
          Text(
            widget.title,
            style: TextStyle(fontSize: 11),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
