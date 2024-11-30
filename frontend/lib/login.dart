import 'package:flutter/material.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  String? _username;
  String? _password;

  final _formKey = GlobalKey<FormState>();

  bool get _isLoginEnabled =>
      _username != null &&
      _username!.isNotEmpty &&
      _password != null &&
      _password!.isNotEmpty;

  final String appleUserName = "AppleUser";
  final String googleUserName = "GoogleUser";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                    child: SingleChildScrollView(
                        child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Image.asset('images/logo.png', height: 150),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Image.asset(
                                        'images/hexagon_left.png',
                                        height: 125,
                                        fit: BoxFit.cover)),
                                TextFormField(
                                    decoration: InputDecoration(
                                        hintText: 'Username',
                                        prefixIcon:
                                            const Icon(Icons.person_outline),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide.none),
                                        filled: true,
                                        fillColor: const Color(0xffE5E5E5)),
                                    onChanged: (value) {
                                      setState(() {
                                        _username = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your username';
                                      }
                                      return null;
                                    }),
                                const SizedBox(height: 20),
                                TextFormField(
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                        hintText: 'Password',
                                        prefixIcon:
                                            const Icon(Icons.lock_outline),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscureText
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscureText = !_obscureText;
                                            });
                                          },
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide.none),
                                        filled: true,
                                        fillColor: const Color(0xffE5E5E5)),
                                    onChanged: (value) {
                                      setState(() {
                                        _password = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      }
                                      return null;
                                    }),
                                const SizedBox(height: 20),
                                SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                        onPressed: _isLoginEnabled
                                            ? () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage(
                                                              username:
                                                                  _username!),
                                                    ),
                                                  );
                                                }
                                              }
                                            : null,
                                        style: ElevatedButton.styleFrom(
                                            foregroundColor:
                                                const Color(0xFF00B4D8),
                                            backgroundColor: _isLoginEnabled
                                                ? const Color(0xFF00B4D8)
                                                : const Color.fromARGB(
                                                    255, 118, 203, 250),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30))),
                                        child: const Text('Login',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white)))),
                                const SizedBox(height: 10),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                        onPressed: () {},
                                        child: const Text('Forgot Password?',
                                            style: TextStyle(
                                                color: Color(0xFF0077B6),
                                                fontWeight: FontWeight.bold)))),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Don't Have an Account? ",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/signup');
                                        },
                                        splashColor: Colors.lightBlueAccent,
                                        child: const Text('Sign Up',
                                            style: TextStyle(
                                                color: Color(0xFF0077B6),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)))
                                  ],
                                ),
                                const SizedBox(height: 4),
                                const Column(
                                  children: [
                                    Text('Or',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15)),
                                    SizedBox(height: 4),
                                    Text('Login with',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15))
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset('images/login_banner.png',
                                        height: 200, fit: BoxFit.cover),
                                    Positioned(
                                        top: -2,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomePage(
                                                                  username:
                                                                      googleUserName)));
                                                },
                                                child: const CircleAvatar(
                                                    radius: 70,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    backgroundImage: AssetImage(
                                                        'images/google_logo.png'))),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage(
                                                              username:
                                                                  appleUserName),
                                                    ),
                                                  );
                                                },
                                                child: const CircleAvatar(
                                                    radius: 70,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    backgroundImage: AssetImage(
                                                        'images/apple_logo.png')))
                                          ],
                                        ))
                                  ],
                                )
                              ],
                            )))))));
  }
}
