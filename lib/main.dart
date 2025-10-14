import 'package:attijari_digital/home/login.dart';
import 'package:attijari_digital/home/password/password.dart';
import 'package:attijari_digital/ouvrir_compte/signature/signature.dart';
import 'package:flutter/material.dart';
import 'package:attijari_digital/home/chat.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:attijari_digital/Welcome.dart';
import 'package:attijari_digital/firebase_options.dart';
import 'ouvrir_compte/auth/otp_verification.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:cloud_functions/cloud_functions.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:uuid/uuid.dart';

/// Instance globale pour notifications locales
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//   //@pragma('vm:entry-point')

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   print("Message reçu en arrière-plan: ${message.notification?.title}");
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure Firebase is initialized before running the app
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');

    // void main() async {
    //   WidgetsFlutterBinding.ensureInitialized();
    //   // Ensure Firebase is initialized before running the app
    //   //try {
    //     await Firebase.initializeApp(
    //       options: DefaultFirebaseOptions.currentPlatform,
    //     );
    //     SystemChrome.setPreferredOrientations(
    //         [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    //     print('Firebase initialized successfully');
    //     // Configuration des notifications push
    //     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    //     const AndroidInitializationSettings initializationSettingsAndroid =
    //         AndroidInitializationSettings('@mipmap/ic_launcher');

    //     const InitializationSettings initializationSettings =
    //         InitializationSettings(android: initializationSettingsAndroid);

    //     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  } catch (e) {
    print('Firebase initialization error: $e');
  }

  runApp(
    AttijariConnectApp(
        // providers: [
        //   ChangeNotifierProvider(create: (_) => AuthProvider()),
        //   // tu peux ajouter d’autres providers ici si besoin
        // ],
        // child: const AttijariConnectApp(),
        ),
  );
}

class AttijariConnectApp extends StatelessWidget {
  const AttijariConnectApp({super.key});

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
        '/otp-verification': (context) => OTPVerificationPage(),
        '/signature': (context) => Signature(),
      },
    );
  }
}
