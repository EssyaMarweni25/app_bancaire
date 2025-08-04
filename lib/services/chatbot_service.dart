import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatbotService {
  static Future<String?> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.45.109:8000/api/chat/'), // modifie si backend en ligne
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "message": message,
          "session_id": "flutter-user-001",
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['response'];
      } else {
        print("Erreur serveur : ${response.body}");
        return "Erreur serveur.";
      }
    } catch (e) {
      print("Erreur réseau : $e");
      return "Impossible de contacter le chatbot.";
    }
  }
}
