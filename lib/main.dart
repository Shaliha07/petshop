import 'package:flutter/material.dart';
import 'login.dart'; // Import the LoginPage
import 'signup.dart'; // Import the SignUpPage
import 'getstarted.dart'; // Import the GetStartedPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/getstarted',
      routes: {
        '/getstarted': (context) => const GetStartedPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => const SignUpPage(),
      },
      // Remove HomePage from the routes map because it requires a dynamic parameter
    );
  }
}
