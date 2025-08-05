import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:attijari_digital/ouvrir%20compte/signature.dart';
import 'package:image_picker/image_picker.dart';

class ConnexionEtBiometrie extends StatefulWidget {
  @override
  _ConnexionEtBiometrieState createState() => _ConnexionEtBiometrieState();
}

class _ConnexionEtBiometrieState extends State<ConnexionEtBiometrie> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController mdpCtrl = TextEditingController();
  final TextEditingController confirmMdpCtrl = TextEditingController();

  bool empreinte = false;
  bool faceId = false;
  File? selfie;

  final Color attijariYellow = const Color(0xFFF4B500);
  final Color attijariRed = const Color(0xFFE2471C);
  final Color glassColor = Colors.white.withOpacity(0.15);

  Future<void> pickSelfie() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        selfie = File(picked.path);
      });
    }
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty)
      return 'Veuillez entrer le mot de passe';
    if (value.length < 8) return 'Au moins 8 caractères';
    if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Au moins une majuscule';
    if (!RegExp(r'[0-9]').hasMatch(value)) return 'Au moins un chiffre';
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value))
      return 'Au moins un symbole';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/attijari-bank.png', fit: BoxFit.cover),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.black.withOpacity(0.6)),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: glassColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Étape 3 & 4 : Connexion + Biométrie",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Nom d'utilisateur
                          buildTextField(
                            controller: usernameCtrl,
                            label: "Nom d'utilisateur souhaité",
                            icon: Icons.person_outline,
                          ),

                          // Mot de passe
                          buildTextField(
                            controller: mdpCtrl,
                            label: "Mot de passe",
                            icon: Icons.lock_outline,
                            obscureText: true,
                            validator: validatePassword,
                          ),

                          // Confirmation mot de passe
                          buildTextField(
                            controller: confirmMdpCtrl,
                            label: "Confirmer le mot de passe",
                            icon: Icons.lock,
                            obscureText: true,
                            validator: (value) {
                              if (value != mdpCtrl.text) {
                                return "Les mots de passe ne correspondent pas";
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 20),
                          Divider(color: Colors.white24),
                          const SizedBox(height: 20),

                          // Empreinte
                          CheckboxListTile(
                            value: empreinte,
                            onChanged: (val) =>
                                setState(() => empreinte = val!),
                            title: Text("Activer l’empreinte digitale",
                                style: TextStyle(color: Colors.white70)),
                            activeColor: attijariRed,
                            checkColor: Colors.white,
                            controlAffinity: ListTileControlAffinity.leading,
                          ),

                          // Face ID
                          CheckboxListTile(
                            value: faceId,
                            onChanged: (val) => setState(() => faceId = val!),
                            title: Text(
                                "Activer Face ID (reconnaissance faciale)",
                                style: TextStyle(color: Colors.white70)),
                            activeColor: attijariRed,
                            checkColor: Colors.white,
                            controlAffinity: ListTileControlAffinity.leading,
                          ),

                          // Capture Selfie
                          const SizedBox(height: 10),
                          selfie == null
                              ? TextButton.icon(
                                  onPressed: pickSelfie,
                                  icon: Icon(Icons.camera_alt,
                                      color: Colors.white70),
                                  label: Text("Capturer votre visage (Selfie)",
                                      style: TextStyle(color: Colors.white70)),
                                )
                              : Column(
                                  children: [
                                    Image.file(selfie!, height: 100),
                                    Text("Selfie capturé",
                                        style:
                                            TextStyle(color: Colors.white70)),
                                  ],
                                ),

                          const SizedBox(height: 30),

                          // Bouton suivant
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Signature()));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.black54,
                              elevation: 4,
                            ),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [attijariRed, attijariYellow],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                constraints: BoxConstraints(
                                    minWidth: 150, minHeight: 50),
                                child: Text(
                                  'Suivant',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: inputType,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(icon, color: Colors.white70),
        ),
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez entrer $label';
              }
              return null;
            },
      ),
    );
  }
}
