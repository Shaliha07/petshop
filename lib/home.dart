import 'package:flutter/material.dart';
import 'chatbot.dart'; // Import the chatbot page

class HomePage extends StatelessWidget {
  final String username;

  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Welcome, $username!', // Use the username here
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // Container with background image and text
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(20),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                fontWeight: FontWeight.w600,
                                color: Colors.purple,
                                height: 1.2,
                              ),
                            ),
                            TextSpan(
                              text: 'LOVED PET',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: const Color.fromARGB(255, 202, 41, 29),
                                fontFamily: 'Poppins',
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Everyday essentials and unique picks to\n',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontFamily: 'Mochiy Pop One',
                                height: 1.5,
                              ),
                            ),
                            TextSpan(
                              text: 'feed and pamper your pet',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontFamily: 'Mochiy Pop One',
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 122, 89, 171),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text('CHECK IT NOW', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: -15,
                    left: 0,
                    child: Image.asset(
                      'images/Banner Cat.png',
                      height: 130,
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
                  IconItem(title: 'Pet Toys', imagePath: 'images/Tennis Ball.png'),
                  IconItem(title: 'Pet Food', imagePath: 'images/Pet Bone.png'),
                  IconItem(title: 'Pet Treats', imagePath: 'images/Dog Bowl.png'),
                  IconItem(title: 'Pet Pharmacy', imagePath: 'images/Insulin Pen.png'),
                ],
              ),
            ),
            // Row with Rectangle image and chatbot icon
            Padding(
  padding: const EdgeInsets.symmetric(horizontal: 5.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // Rectangle image
      Expanded(
        child: Image.asset('images/Rectangle 3780.png'),
      ),
      // SizedBox with minimal width to reduce the space
      SizedBox(width: 1), // You can adjust this value to control the space
      // Column to hold both the chatbot and real-time communication icons
      Column(
        children: [
          // Chatbot icon button
          IconButton(
            icon: Image.asset('images/chatbot.png', height: 50),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatbotPage()),
              );
            },
          ),
          // Real-time communication icon button
          IconButton(
            icon: Image.asset('images/call button.png', height: 40),
            onPressed: () {
              // Add your navigation or functionality for real-time communication here
            },
          ),
        ],
      ),
    ],
  ),
),

          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('images/Home.png', height: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/Cart.png', height: 30),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/Pets.png', height: 30),
            label: 'Pets',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/Calendar.png', height: 30),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('images/User.png', height: 30),
            label: 'Profile',
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 97, 184, 250),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
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
  Color containerColor = Colors.grey[100]!; // Default color
  Color pressedColor = Colors.blue[100]!; // Pressed color
  Color originalColor = Colors.grey[100]!; // Original color

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          containerColor = pressedColor; // Change color when pressed
        });
      },
      onTapUp: (_) {
        setState(() {
          containerColor = originalColor; // Revert to original color when released
        });
      },
      onTapCancel: () {
        setState(() {
          containerColor = originalColor; // Revert to original color if tap is canceled
        });
      },
      child: Column(
        children: <Widget>[
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: containerColor, // Dynamic color
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Image.asset(widget.imagePath, height: 40),
            ),
          ),
          SizedBox(height: 5),
          Text(
            widget.title,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
