import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
// Corrigé: Remplacé %20 par un espace ou renommez le fichier
import 'package:attijari_digital/ouvrir compte/connexion.dart';
import 'package:image_picker/image_picker.dart';

class Signature extends StatefulWidget {
  @override
  _SignatureState createState() => _SignatureState();
}

class _SignatureState extends State<Signature> {
  bool cguAccepted = false;
  Uint8List? signatureImage;
  List<Offset?> _points = [];
  final TextEditingController otpController = TextEditingController();
  // Ajout d'une clé globale pour le GestureDetector
  final GlobalKey _signatureKey = GlobalKey();

  final Color attijariYellow = const Color(0xFFF4B500);
  final Color attijariRed = const Color(0xFFE2471C);
  final Color glassColor = Colors.white.withOpacity(0.15);

  Future<void> _pickSignatureImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final imageBytes = await picked.readAsBytes();
      setState(() => signatureImage = imageBytes);
    }
  }

  void _clearSignature() {
    setState(() {
      _points.clear();
      signatureImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 🌈 Fond dégradé
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [attijariYellow, attijariRed],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // 🌫 Contenu flou avec effet glass
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
                      children: [
                        Text(
                          "Étape 5 : Signature et Validation",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // 🔏 Signature ou image
                        Text(
                          "Veuillez signer ci-dessous :",
                          style: TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 5),
                        // CORRECTION MAJEURE: Utilisation d'une clé et du bon contexte
                        Container(
                          key: _signatureKey,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white54, width: 1),
                          ),
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              // CORRECTION: Utilisation du bon RenderBox
                              RenderBox? box = _signatureKey.currentContext
                                  ?.findRenderObject() as RenderBox?;
                              if (box != null) {
                                Offset localPosition =
                                    box.globalToLocal(details.globalPosition);
                                setState(() {
                                  _points = List.from(_points)..add(localPosition);
                                });
                              }
                            },
                            onPanEnd: (_) {
                              // CORRECTION: Utilisation de setState
                              setState(() {
                                _points.add(null);
                              });
                            },
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: signatureImage != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.memory(
                                        signatureImage!,
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                  : CustomPaint(
                                      painter: SignaturePainter(_points),
                                      child: Container(),
                                    ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: _clearSignature,
                              child: Text("Effacer",
                                  style: TextStyle(color: Colors.white70)),
                            ),
                            TextButton(
                              onPressed: _pickSignatureImage,
                              child: Text("Télécharger une image",
                                  style: TextStyle(color: Colors.white70)),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // 🔐 OTP
                        TextFormField(
                          controller: otpController,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: "Code OTP reçu par SMS",
                            labelStyle: TextStyle(color: Colors.white70),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.05),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Icon(Icons.lock, color: Colors.white70),
                            // Suppression du compteur de caractères pour un meilleur design
                            counterText: "",
                          ),
                        ),

                        const SizedBox(height: 10),

                        // ☑️ CGU
                        CheckboxListTile(
                          value: cguAccepted,
                          onChanged: (value) {
                            setState(() => cguAccepted = value ?? false);
                          },
                          title: Text(
                            "J'accepte les Conditions Générales de Banque",
                            style: TextStyle(color: Colors.white70),
                          ),
                          activeColor: attijariRed,
                          checkColor: Colors.white,
                          controlAffinity: ListTileControlAffinity.leading,
                        ),

                        const SizedBox(height: 30),

                        // 🔘 Bouton soumettre - CORRECTION: Validation améliorée
                        ElevatedButton(
                          onPressed: _canSubmit()
                              ? () {
                                  _submitForm();
                                }
                              : null,
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
                              constraints:
                                  BoxConstraints(minWidth: 150, minHeight: 50),
                              child: Text(
                                'Soumettre',
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
        ],
      ),
    );
  }

  // AJOUT: Méthode pour vérifier si on peut soumettre
  bool _canSubmit() {
    return cguAccepted &&
        otpController.text.length == 6 &&
        (_points.isNotEmpty || signatureImage != null);
  }

  // AJOUT: Méthode pour soumettre le formulaire
  void _submitForm() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Compte soumis !"),
        content: Text("Votre demande a été enregistrée avec succès."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Navigation vers la page suivante si nécessaire
              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => NextPage()));
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }
}

// 🎨 Signature CustomPainter - AMÉLIORÉ
class SignaturePainter extends CustomPainter {
  final List<Offset?> points;
  SignaturePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.5;

    // CORRECTION: Meilleure gestion du dessin
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        // Vérification que les points sont dans les limites du canvas
        final point1 = points[i]!;
        final point2 = points[i + 1]!;
        
        if (point1.dx >= 0 && point1.dx <= size.width &&
            point1.dy >= 0 && point1.dy <= size.height &&
            point2.dx >= 0 && point2.dx <= size.width &&
            point2.dy >= 0 && point2.dy <= size.height) {
          canvas.drawLine(point1, point2, paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) => 
      oldDelegate.points.length != points.length;
}