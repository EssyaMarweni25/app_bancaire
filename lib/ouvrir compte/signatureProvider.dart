import 'package:flutter/foundation.dart';

class SignatureProvider with ChangeNotifier {
  String _otp = '';
  bool _cguAccepted = false;

  String get otp => _otp;
  bool get cguAccepted => _cguAccepted;
  bool get canSubmit => _cguAccepted && _otp.length == 6;

  void setOtp(String newOtp) {
    _otp = newOtp;
    notifyListeners();
  }

  void setCguAccepted(bool value) {
    _cguAccepted = value;
    notifyListeners();
  }
}
