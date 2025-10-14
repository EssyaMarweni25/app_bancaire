import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;
  bool _isLoading = false;

  String? get verificationId => _verificationId;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Envoi du lien de réinitialisation de mot de passe par email
  Future<void> sendPasswordResetEmail(String email) async {
    _setLoading(true);
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      debugPrint('Error sending password reset email: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Envoi du code OTP par SMS
  Future<void> sendOtp(String phoneNumber) async {
    _setLoading(true);
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          _setLoading(false);
        },
        verificationFailed: (FirebaseAuthException e) {
          _setLoading(false);
          debugPrint('Verification Failed: ${e.message}');
        },
        codeSent: (String verId, int? resendToken) {
          _verificationId = verId;
          _setLoading(false);
        },
        codeAutoRetrievalTimeout: (String verId) {
          _verificationId = verId;
          _setLoading(false);
        },
      );
    } catch (e) {
      _setLoading(false);
      debugPrint('Error sending OTP: $e');
    }
  }

  /// Vérification du code OTP
  Future<UserCredential?> verifyOtp(String otp) async {
    if (_verificationId == null) return null;
    _setLoading(true);
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );
      final user = await _auth.signInWithCredential(credential);
      _setLoading(false);
      return user;
    } catch (e) {
      _setLoading(false);
      debugPrint('Error verifying OTP: $e');
      return null;
    }
  }
}
