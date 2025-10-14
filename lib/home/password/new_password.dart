import 'package:flutter/material.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({super.key});

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  // Code exemple pour valider
  final String correctCode =
      "123456"; // Ici tu mettras le vrai code envoyé par mail/SMS

  void _validateAndProceed() {
    if (_codeController.text != correctCode) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Code invalide")),
      );
      return;
    }

    if (_passController.text.isEmpty || _passController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mot de passe trop court")),
      );
      return;
    }

    // Ici : mettre à jour le mot de passe via Firebase Auth si nécessaire

    // Rediriger vers le Dashboard et supprimer l'historique
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const DashboardPage()),
      (route) => false,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Mot de passe changé avec succès")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nouveau mot de passe")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Code reçu par email ou SMS",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Nouveau mot de passe",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _validateAndProceed,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Valider"),
            ),
          ],
        ),
      ),
    );
  }
}

// Page Dashboard exemple
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: const Center(
        child: Text(
          "Bienvenue dans le Dashboard !",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
