import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'getstarted.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'token_manager.dart'; // Import the Singleton

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await TokenManager.instance.loadToken(); // Load token on app start

  // Check if token exists and is valid
  String? token = TokenManager.instance.accessToken;
  bool isAuthenticated = token != null && token.isNotEmpty;

  runApp(MyApp(isAuthenticated: isAuthenticated));
}

class MyApp extends StatelessWidget {
  final bool isAuthenticated;

  const MyApp({super.key, required this.isAuthenticated});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: TokenManager.instance.accessToken == null
          ? '/getstarted' // Show GetStarted if no token
          : '/login', // Otherwise redirect to login (or home if logged in),
      routes: {
        '/getstarted': (context) => const GetStartedPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
      },
    );
  }
}
