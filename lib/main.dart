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
import 'package:attijari_digital/firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Message en arrière-plan : ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Demande de permission iOS & Android
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print(' Notifications autorisées');
  } else {
    print(' Notifications refusées');
  }

  // Token FCM (à utiliser pour tester les messages ciblés
  String? token = await messaging.getToken();
  print("Token FCM : $token");

  // Message en foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print(" Nouveau message en foreground : ${message.notification?.title}");
  });

  // Message cliqué depuis background
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("App ouverte via notification : ${message.notification?.title}");
  });

  runApp(AttijariConnectApp());
}

class AttijariConnectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Attijari Digital',
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
