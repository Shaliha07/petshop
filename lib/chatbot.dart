import 'package:flutter/material.dart';

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {'text': "Hi Max, How can I help you today?", 'isBot': true},
    {'text': "Hi, I’m looking for a dog food recommendation", 'isBot': false},
    {'text': "Can you please tell me the breed and age of your dog?", 'isBot': true},
  ];

  void _sendMessage() {
    if (_controller.text.isEmpty) return;

    setState(() {
      _messages.add({'text': _controller.text, 'isBot': false});
      _controller.clear();
    });

    // Simulate a response from the bot after a delay
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _messages.add({
          'text': "Here's a response to '${_messages.last['text']}'",
          'isBot': true
        });
      });
    });
  }

  // Function to show a bottom sheet with attachment options
  void _showAttachmentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          padding: EdgeInsets.all(10),
          height: 250,
          child: Column(
            children: [
              Expanded(
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  children: [
                    _buildAttachmentOption(Icons.insert_photo, "Gallery", () {
                      Navigator.pop(context);
                    }),
                    _buildAttachmentOption(Icons.camera_alt, "Camera", () {
                      Navigator.pop(context);
                    }),
                    _buildAttachmentOption(Icons.insert_drive_file, "Document", () {
                      Navigator.pop(context);
                    }),
                    _buildAttachmentOption(Icons.location_on, "Location", () {
                      Navigator.pop(context);
                    }),
                    _buildAttachmentOption(Icons.person, "Contact", () {
                      Navigator.pop(context);
                    }),
                    _buildAttachmentOption(Icons.audiotrack, "Audio", () {
                      Navigator.pop(context);
                    }),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAttachmentOption(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 30,
            child: Icon(icon, size: 28, color: Colors.blue),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(String text, bool isBot) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isBot)
            CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('images/chatbot.png'), // Path to the image
            ),
          if (!isBot) SizedBox(width: 40),
          SizedBox(width: 10),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
            decoration: BoxDecoration(
              color: isBot ? const Color(0xFF54D8F7) : const Color(0xFFE6F4F8),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isBot ? Colors.black : Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
          SizedBox(width: 10),
          if (!isBot)
            CircleAvatar(
              backgroundImage: AssetImage('images/dognew.png'), // Path to user avatar
            ),
          if (isBot) SizedBox(width: 40),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00B4D8), // Color of the AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Back to HomePage
          color: Colors.white,
        ),
        title: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.white),
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white60),
            filled: true,
            fillColor: Color(0xFF90E0EF),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar and Icon Section
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Image.asset(
                  'images/chatbot.png', // Path to the chatbot icon
                  width: 100,
                  height: 100,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: _messages.map((message) => _buildChatBubble(message['text'], message['isBot'])).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: "Type Message",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.attach_file),
                          onPressed: () => _showAttachmentOptions(context),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: _sendMessage,
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0xFF00B4D8),
                    child: Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
