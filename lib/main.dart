import 'package:attijari_digital/home/login.dart';
import 'package:attijari_digital/home/password.dart';
import 'package:attijari_digital/ouvrir%20compte/signature.dart';
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
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:attijari_digital/firebase_options.dart';
import 'ouvrir compte/otp_verification.dart';
import 'package:firebase_core_web/firebase_core_web.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure Firebase is initialized before running the app
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, 
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Firebase initialization error: $e');
  }

  runApp(AttijariConnectApp());
}

class AttijariConnectApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attijari Digital',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Welcome(),
        '/login': (context) => Login(),
        '/chat': (context) => const Chat(),
        '/forgot-password': (context) => Password(),
        // Add the new route for OTP verification
        '/otp-verification': (context) => OtpVerification(),
        '/signature': (context) => Signature(),
      },
    );
  }
}
