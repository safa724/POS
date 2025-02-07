import 'package:flutter/material.dart';
import 'package:pos/constants.dart';

class HelpChat extends StatefulWidget {
  const HelpChat({super.key});

  @override
  State<HelpChat> createState() => _HelpChatState();
}

class _HelpChatState extends State<HelpChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'POS Support Team',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/nochat.webp', color: primaryColor, height: 140),
            const SizedBox(height: 10),
            const Text('You Have No Chats', style: TextStyle(fontSize: 20)),
            const Text('Start a new one', style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Handle starting a new conversation
        },
        backgroundColor: primaryColor,
        label: const Text(
          'New Conversation',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(Icons.chat, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
