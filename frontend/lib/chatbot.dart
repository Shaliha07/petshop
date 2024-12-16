import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shane_and_shawn_petshop/globals.dart';
import 'package:shane_and_shawn_petshop/token_manager.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  List<Map<String, dynamic>> messages = [
    {"isBot": true, "text": "Hi $globalUsername, How can I help you today?"},
  ];

  final TextEditingController _controller = TextEditingController();
  bool isLoading = false;

  Future<void> sendMessage(String userMessage) async {
    setState(() {
      messages.add({"isBot": false, "text": userMessage});
      isLoading = true;
    });

    final token = TokenManager.instance.accessToken;

    //final localIp = dotenv.env['LOCAL_IP'];
    //final url = Uri.parse('$localIp/chatbot/');

    final url = Uri.parse('https://4536-35-184-93-79.ngrok-free.app/chat');

    void addBotMessage(String text) {
      setState(() {
        messages.add({"isBot": true, "text": text});
        isLoading = false;
      });
    }

    if (token == null) {
      addBotMessage("No access token available. Please log in again.");
      return;
    }

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({"message": userMessage}),
        //body: json.encode({"query": userMessage}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        addBotMessage(data['response'] ?? "No response from server.");
      } else {
        final errorData = json.decode(response.body) as Map<String, dynamic>;
        addBotMessage(errorData['message'] ?? "Failed to process the request.");
      }
    } catch (error) {
      print("Error sending message: $error");
      addBotMessage("Error connecting to the server. Please try again later.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // Search Bar
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

            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Image.asset(
                        'images/chatbot.png',
                        height: 100,
                      ),
                    ),
                    ...List.generate(messages.length, (index) {
                      return buildMessage(messages[index]);
                    }),
                  ],
                ),
              ),
            ),

            if (isLoading)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _controller,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Type Message",
                                    hintStyle:
                                        TextStyle(color: Color(0xff65558F)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      GestureDetector(
                        onTap: () {
                          if (_controller.text.trim().isNotEmpty) {
                            sendMessage(_controller.text.trim());
                            _controller.clear();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: const Icon(
                            Icons.send,
                            color: Color(0xff65558F),
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMessage(Map<String, dynamic> message) {
    bool isBot = message["isBot"];
    return Align(
      alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Row(
        mainAxisAlignment:
            isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isBot) ...[
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Image.asset(
                'images/chatbot.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: isBot ? Colors.lightBlueAccent : Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                message["text"],
                textAlign: isBot ? TextAlign.left : TextAlign.right,
                style: TextStyle(
                  color: isBot ? Colors.black : Colors.black,
                ),
              ),
            ),
          ),
          if (!isBot) ...[
            const SizedBox(width: 8),
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                'images/user_avatar.png',
              ),
            ),
          ],
        ],
      ),
    );
  }
}
