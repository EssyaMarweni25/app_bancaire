import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Chat extends StatefulWidget {
  const Chat({super.key});
  final Color attijariYellow = const Color(0xFFF4B500);
  final Color attijariRed = const Color(0xFFE2471C);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  //final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  Future<void> sendMessage() async {
    final message = _controller.text.trim();
    if (message.isEmpty) return;

    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.post(
        Uri.parse('http://192.168.45.109:8000/api/chat/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "message": message,
          "session_id": "flutter-user-001",
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final botResponse = data['response'];
        _showResponseDialog(botResponse);
      } else {
        _showResponseDialog("Erreur serveur : ${response.statusCode}");
      }
    } catch (e) {
      _showResponseDialog("Erreur réseau : $e");
    } finally {
      setState(() {
        _isLoading = false;
        _controller.clear();
      });
    }
  }

  void _showResponseDialog(String response) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Réponse du Chatbot"),
        content: Text(response),
        actions: [
          TextButton(
            child: const Text("Fermer"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF4B500), Color(0xFFE2471C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 70,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFF4B500), Color(0xFFE2471C)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Image.asset(
                        "assets/image/appbar1.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 16,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    const Positioned(
                      child: Text(
                        "Attijari Assist",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Écrivez votre message...",
                          hintStyle: const TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: _isLoading ? null : sendMessage,
                      ),
                    ),
                  ],
                ),
              ),
              //  const Divider(color: Colors.white30, height: 1),
              const Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Text(
                  "Ce chatbot respecte le RGPD",
                  style: TextStyle(fontSize: 12, color: Colors.white70),
                  //textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
