// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'auth_service.dart';

// class ApiService {
//   final String baseUrl = "http://127.0.0.1:8000/";
//   //"http://192.168.1.10:8000/api/"; // <--- change selon ton IP/backend
//   final AuthService _auth = AuthService();

//   Future<List<dynamic>> fetchNotes() async {
//     final token = await _auth.getIdToken();
//     final resp = await http.get(
//       Uri.parse(baseUrl + 'notes/'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );
//     if (resp.statusCode == 200) {
//       return json.decode(resp.body);
//     } else {
//       throw Exception('Failed to fetch notes: ${resp.statusCode} ${resp.body}');
//     }
//   }

//   Future<Map<String, dynamic>> createNote(String title, String body) async {
//     final token = await _auth.getIdToken();
//     final resp = await http.post(
//       Uri.parse(baseUrl + 'notes/'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//       body: json.encode({'title': title, 'body': body}),
//     );
//     if (resp.statusCode == 201) {
//       return json.decode(resp.body);
//     } else {
//       throw Exception('Failed to create note: ${resp.statusCode} ${resp.body}');
//     }
//   }
// }
