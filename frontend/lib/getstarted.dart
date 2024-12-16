import 'package:flutter/material.dart';
import 'login.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2E9E2),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Center(
                        child: Image.asset(
                          'images/logo.png',
                          height: 200,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 300,
                      height: 260,
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.asset(
                              'images/get_started_decoration.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                style: TextStyle(
                                    fontSize: 30,
                                    height: 1.52,
                                    letterSpacing: 0.035,
                                    color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Helping you\n',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text: 'to keep ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'your bestie',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Color.fromARGB(255, 39, 120, 186),
                                    ),
                                  ),
                                  TextSpan(
                                    text: '\nstay healthy!',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 317,
              padding: const EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(65)),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Image.asset(
                      'images/get_started_banner.png',
                      height: 450,
                      width: 430,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Positioned(
                    bottom: 240,
                    child: GetStartedButton(),
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

class GetStartedButton extends StatefulWidget {
  const GetStartedButton({super.key});

  @override
  _GetStartedButtonState createState() => _GetStartedButtonState();
}

class _GetStartedButtonState extends State<GetStartedButton> {
  final Color _buttonColor = const Color(0xFF0077B6);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              color: _buttonColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Center(
              child: Text(
                "Get Started",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            child: Image.asset(
              'images/paw_icon.png',
              height: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
