import 'package:flutter/material.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  List<Map<String, dynamic>> messages = [
    {"isBot": true, "text": "Hi Max, How can I help you today ?"},
    {"isBot": false, "text": "Hi, I'm looking for a dog food recommendation"},
    {
      "isBot": true,
      "text": "Can you please tell me the breed and age of your dog?"
    },
  ];

  bool showAttachments = false;

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

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Image.asset(
                'images/chatbot.png',
                height: 100,
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: List.generate(messages.length, (index) {
                    return buildMessage(messages[index]);
                  }),
                ),
              ),
            ),

            Column(
              children: [
                if (showAttachments) buildAttachments(),
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
                              const Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Type Message",
                                    hintStyle:
                                        TextStyle(color: Color(0xff65558F)),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showAttachments = !showAttachments;
                                  });
                                },
                                child: const Icon(
                                  Icons.attach_file,
                                  color: Color(0xff65558F),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: const Icon(
                          Icons.send,
                          color: Color(0xff65558F),
                          size: 30,
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
                  color: isBot ? Colors.white : Colors.black,
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

  Widget buildAttachments() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildAttachmentIcon(Icons.photo, "Gallery"),
          buildAttachmentIcon(Icons.camera_alt, "Camera"),
          buildAttachmentIcon(Icons.audiotrack, "Audio"),
        ],
      ),
    );
  }

  Widget buildAttachmentIcon(IconData icon, String label) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xff65558F)),
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          label,
          style: const TextStyle(color: Color(0xff65558F)),
        ),
      ],
    );
  }
}
