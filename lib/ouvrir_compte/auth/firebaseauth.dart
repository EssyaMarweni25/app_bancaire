import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

void sendSmsCode(String phoneNumber) async {
  await auth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    verificationCompleted: (PhoneAuthCredential credential) async {
      // Auto login possible sur certains appareils
      // ✅ Protection contre null
      await auth.signInWithCredential(credential);
      print("Auto-login réussi !");
    },
    verificationFailed: (FirebaseAuthException e) {
      print("Erreur: ${e.message}");
    },
    codeSent: (String verificationId, int? resendToken) {
      // Sauvegarder verificationId pour valider plus tard
      print("Code envoyé! verificationId: $verificationId");

      // Si tu veux utiliser resendToken, vérifie qu’il n’est pas null
      if (resendToken != null) {
        print("Resend token: $resendToken");
      }
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      // Vérification automatique expirée
      print("Timeout du code auto: $verificationId");
    },
  );
}

void verifySmsCode(String verificationId, String smsCode) async {
  try {
    // Créer les credentials
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    // Sign in
    await auth.signInWithCredential(credential);
    print("Numéro validé et connecté!");
  } catch (e) {
    print("Erreur de validation du code SMS: $e");
  }
}
