// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'auth_provider.dart';
// import 'otp_verification.dart';
// import 'otp_verification.dart';

// class AuthPage extends StatefulWidget {
//   const AuthPage({super.key});

//   @override
//   _AuthPageState createState() => _AuthPageState();
// }

// class _AuthPageState extends State<AuthPage> {
//   final TextEditingController _phoneController = TextEditingController();

//   @override
//   void dispose() {
//     _phoneController.dispose();
//     super.dispose();
//   }

//   void _sendOtp(BuildContext context) async {
//     final authProvider = Provider.of<AuthProvider>(context, listen: false);
//     if (_phoneController.text.isNotEmpty) {
//       await authProvider.sendOtp('+216${_phoneController.text.trim()}');
//       if (authProvider.verificationId != null) {
//         if (mounted) {
//           // Navigate to the new OTP verification page
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const OtpVerification()),
//           );
//         }
//       }
//     }
//   }

//   @override
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
//               const Icon(Icons.phone_android,
//                   size: 80, color: Colors.blueAccent),
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
//                   onPressed:
//                       authProvider.isLoading ? null : () => _sendOtp(context),
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
import 'package:provider/provider.dart';
import 'auth_provider.dart';
import 'otp_verification.dart'; // Importez la nouvelle page

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _sendOtp(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (_phoneController.text.isNotEmpty) {
      await authProvider.sendOtp('+216${_phoneController.text.trim()}');
      if (authProvider.verificationId != null) {
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OtpVerification()),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Authentication'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Icon(Icons.phone_android,
                  size: 80, color: Colors.blueAccent),
              const SizedBox(height: 30),
              const Text(
                'Enter your phone number to receive an OTP.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number (e.g., 55123456)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixText: '+216 ',
                  prefixStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      authProvider.isLoading ? null : () => _sendOtp(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: authProvider.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Get OTP',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
