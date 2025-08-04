import 'package:attijari_digital/home/login.dart';
import 'package:attijari_digital/home/password.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:attijari_digital/home/chat.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:local_auth/local_auth.dart';
import 'package:attijari_digital/Welcome.dart';

void main() => runApp(AttijariConnectApp());

class AttijariConnectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Attijari Digital',
        // home: Login(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/', // 👈 Route d'accueil = WelcomeScreen
        routes: {
          '/': (context) => Welcome(), // 👈 Premier écran
          '/login': (context) => Login(),
          '/chat': (context) => const Chat(),
          '/forgot-password': (context) => Password(),
        });
  }
}
