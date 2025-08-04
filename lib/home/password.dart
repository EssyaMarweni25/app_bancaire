import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class Password extends StatelessWidget {
  Password({super.key});

  final Color attijariYellow = const Color(0xFFF4B500);
  final Color attijariRed = const Color(0xFFE2471C);
  final Color glassColor = Colors.white.withOpacity(0.15);
  final TextEditingController idController = TextEditingController();
  // ✅ Fonction d’authentification biométrique
  Future<void> authenticateBiometric(BuildContext context) async {
    final LocalAuthentication auth = LocalAuthentication();

    try {
      bool canCheck = await auth.canCheckBiometrics;
      bool isDeviceSupported = await auth.isDeviceSupported();

      if (canCheck && isDeviceSupported) {
        bool authenticated = await auth.authenticate(
          localizedReason: 'Veuillez vous authentifier pour continuer',
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
          ),
        );

        if (authenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Authentification réussie ")),
          );
          // 👉 Rediriger ou lancer réinitialisation ici si tu veux
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Échec de l'authentification ")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Biométrie non disponible")),
        );
      }
    } catch (e) {
      print("Erreur biométrie: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur d'authentification")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Réinitialiser le mot de passe"),
        backgroundColor: attijariRed,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [attijariYellow, attijariRed],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: glassColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Veuillez vous identifier pour réinitialiser votre mot de passe.",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(height: 20),

                        // Champ numéro client ou CIN
                        TextField(
                          controller: idController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Numéro client ou CIN",
                            labelStyle: const TextStyle(color: Colors.white70),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.05),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Bouton Empreinte
                        ElevatedButton.icon(
                          onPressed: () => authenticateBiometric(context),
                          icon: const Icon(Icons.fingerprint),
                          label: const Text("Utiliser l'empreinte digitale"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.1),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Bouton Face ID
                        ElevatedButton.icon(
                          onPressed: () => authenticateBiometric(context),
                          icon: const Icon(Icons.face),
                          label: const Text("Utiliser Face ID"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.1),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Bouton Réinitialiser
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text("Lien de réinitialisation envoyé"),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: attijariRed,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                          ),
                          child: const Text("Réinitialiser"),
                        ),

                        const SizedBox(height: 20),

                        // Lien retour
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "← Retour à la connexion",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ],
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
}
