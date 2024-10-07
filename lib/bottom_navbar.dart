import 'package:flutter/material.dart';
import 'package:shane_and_shawn_petshop/home.dart';
import 'package:shane_and_shawn_petshop/products_page.dart';
import 'package:shane_and_shawn_petshop/services_page.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.grey[200],
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(username: 'Max'),
              ),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductsPage(),
              ),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ServicesPage(),
              ),
            );
          }
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: BottomNavIcon('images/home_icon.png', currentIndex == 0),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: BottomNavIcon('images/cart_icon.png', currentIndex == 1),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: BottomNavIcon('images/pet_icon.png', currentIndex == 2),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: BottomNavIcon('images/calender_icon.png', currentIndex == 3),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: BottomNavIcon('images/user_icon.png', currentIndex == 4),
          label: '',
        ),
      ],
    );
  }
}

class BottomNavIcon extends StatelessWidget {
  final String assetPath;
  final bool isSelected;

  const BottomNavIcon(this.assetPath, this.isSelected, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey[400] : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Image.asset(
        assetPath,
        width: 35,
        height: 35,
      ),
    );
  }
}
