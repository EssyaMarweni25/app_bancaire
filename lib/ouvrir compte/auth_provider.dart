// // TODO Implement this library.
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:pinput/pinput.dart';
// import 'auth_provider.dart';
// import 'otp_verification.dart'; // Ensure you have this file
// //import 'home_page.dart'; // Ensure you have this file

// class AuthPage extends StatefulWidget {
//   const AuthPage({super.key});

//   @override
//   _AuthPageState createState() => _AuthPageState();
// }

// class _AuthPageState extends State<AuthPage> {
//   final TextEditingController _phoneController = TextEditingController();
//   // final TextEditingController _otpController = TextEditingController();
//   // bool _isOtpSent = false;

//   @override
//   void dispose() {
//     _phoneController.dispose();
//     // _otpController.dispose();
//     super.dispose();
//   }

//   void _sendOtp(BuildContext context) async {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     if (_phoneController.text.isNotEmpty) {
//       await authProvider.sendOtp('+216${_phoneController.text.trim()}');
//       if (authProvider.verificationId != null) {
//         if (mounted) {
//           // Naviguer vers la page de vérification de l'OTP
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => const OtpVerification()),
//           );
//         }
//       }
//     }
//   }

// //   void _verifyOtp(BuildContext context) async {
// //     final authProvider = Provider.of<AuthProvider>(context, listen: false);
// //     if (_otpController.text.isNotEmpty) {
// //       final userCredential = await authProvider.verifyOtp(_otpController.text);
// //       if (userCredential != null) {
// //         if (mounted) {
// //           // Navigate to the home page on success
// //           Navigator.pushReplacement(
// //             context,
// //             MaterialPageRoute(builder: (context) => const HomePage()),
// //           );
// //         }
// //       } else {
// //         // Show an error message for invalid OTP
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(content: Text('Invalid OTP. Please try again.')),
// //         );
// //       }
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final authProvider = Provider.of<AuthProvider>(context);

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Phone Authentication'),
// //         centerTitle: true,
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(24.0),
// //         child: SingleChildScrollView(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               const SizedBox(height: 50),
// //               // Use an icon to give a visual identity
// //               const Icon(Icons.phone_android,
// //                   size: 80, color: Colors.blueAccent),
// //               const SizedBox(height: 30),
// //               const Text(
// //                 'Enter your phone number to receive an OTP.',
// //                 textAlign: TextAlign.center,
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
// //               ),
// //               const SizedBox(height: 40),
// //               if (!_isOtpSent)
// //                 _buildPhoneInput(context, authProvider)
// //               else
// //                 _buildOtpInput(context, authProvider),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildPhoneInput(BuildContext context, AuthProvider authProvider) {
// //     return Column(
// //       children: [
// //         TextField(
// //           controller: _phoneController,
// //           keyboardType: TextInputType.phone,
// //           decoration: InputDecoration(
// //             labelText: 'Phone Number (e.g., 55123456)',
// //             border: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(12),
// //             ),
// //             prefixText: '+216 ',
// //             prefixStyle: const TextStyle(fontWeight: FontWeight.bold),
// //           ),
// //         ),
// //         const SizedBox(height: 20),
// //         SizedBox(
// //           width: double.infinity,
// //           height: 50,
// //           child: ElevatedButton(
// //             onPressed: authProvider.isLoading ? null : () => _sendOtp(context),
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.blueAccent,
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //             ),
// //             child: authProvider.isLoading
// //                 ? const CircularProgressIndicator(color: Colors.white)
// //                 : const Text(
// //                     'Get OTP',
// //                     style: TextStyle(color: Colors.white, fontSize: 16),
// //                   ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildOtpInput(BuildContext context, AuthProvider authProvider) {
// //     // Define a default style for Pinput
// //     final defaultPinTheme = PinTheme(
// //       width: 56,
// //       height: 56,
// //       textStyle: const TextStyle(
// //           fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
// //       decoration: BoxDecoration(
// //         border: Border.all(color: Colors.black.withOpacity(0.3)),
// //         borderRadius: BorderRadius.circular(12),
// //       ),
// //     );

// //     return Column(
// //       children: [
// //         const Text(
// //           'A 6-digit code has been sent to your number. Enter it below to verify.',
// //           textAlign: TextAlign.center,
// //           style: TextStyle(fontSize: 16, color: Colors.grey),
// //         ),
// //         const SizedBox(height: 30),
// //         Pinput(
// //           controller: _otpController,
// //           length: 6,
// //           defaultPinTheme: defaultPinTheme,
// //           focusedPinTheme: defaultPinTheme.copyDecorationWith(
// //             border: Border.all(color: Colors.blueAccent),
// //             borderRadius: BorderRadius.circular(8),
// //           ),
// //           onCompleted: (pin) => _verifyOtp(context),
// //         ),
// //         const SizedBox(height: 20),
// //         SizedBox(
// //           width: double.infinity,
// //           height: 50,
// //           child: ElevatedButton(
// //             onPressed:
// //                 authProvider.isLoading ? null : () => _verifyOtp(context),
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: Colors.blueAccent,
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //             ),
// //             child: authProvider.isLoading
// //                 ? const CircularProgressIndicator(color: Colors.white)
// //                 : const Text(
// //                     'Verify',
// //                     style: TextStyle(color: Colors.white, fontSize: 16),
// //                   ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
//  @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Phone Authentication'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 50),
//               const Icon(Icons.phone_android, size: 80, color: Colors.blueAccent),
//               const SizedBox(height: 30),
//               const Text(
//                 'Enter your phone number to receive an OTP.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(height: 40),
//               TextField(
//                 controller: _phoneController,
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(
//                   labelText: 'Phone Number (e.g., 55123456)',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   prefixText: '+216 ',
//                   prefixStyle: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: authProvider.isLoading ? null : () => _sendOtp(context),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blueAccent,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: authProvider.isLoading
//                       ? const CircularProgressIndicator(color: Colors.white)
//                       : const Text(
//                           'Get OTP',
//                           style: TextStyle(color: Colors.white, fontSize: 16),
//                         ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;
  bool _isLoading = false;

  String? get verificationId => _verificationId;
  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> sendOtp(String phoneNumber) async {
    setIsLoading(true);
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          setIsLoading(false);
        },
        verificationFailed: (FirebaseAuthException e) {
          setIsLoading(false);
          debugPrint('Verification Failed: ${e.message}');
        },
        codeSent: (String verId, int? resendToken) {
          _verificationId = verId;
          setIsLoading(false);
          debugPrint('Code Sent. Verification ID: $_verificationId');
        },
        codeAutoRetrievalTimeout: (String verId) {
          _verificationId = verId;
          setIsLoading(false);
        },
      );
    } catch (e) {
      setIsLoading(false);
      debugPrint('Error sending OTP: $e');
    }
  }

  Future<UserCredential?> verifyOtp(String otp) async {
    setIsLoading(true);
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );
      final userCredential = await _auth.signInWithCredential(credential);
      setIsLoading(false);
      return userCredential;
    } catch (e) {
      setIsLoading(false);
      debugPrint('Error verifying OTP: $e');
      return null;
    }
  }
}
