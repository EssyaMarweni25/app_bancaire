import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'profil.dart';

class Identification extends StatefulWidget {
  const Identification({super.key});

  @override
  State<Identification> createState() => _IdentificationState();
}

class _IdentificationState extends State<Identification> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nomCtrl = TextEditingController();
  final TextEditingController dateNaissanceCtrl = TextEditingController();
  final TextEditingController cinCtrl = TextEditingController();
  final TextEditingController nationaliteCtrl = TextEditingController();
  final TextEditingController sexeCtrl = TextEditingController();
  final TextEditingController adresseCtrl = TextEditingController();
  final TextEditingController telCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();

  File? _imageCIN;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageCIN = File(pickedFile.path);
      });
    }
  }

  final Color attijariYellow = const Color(0xFFF4B500);
  final Color attijariRed = const Color(0xFFE2471C);
  final Color glassColor = Colors.white.withOpacity(0.15);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/attijari-bank.png', fit: BoxFit.cover),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(color: Colors.black.withOpacity(0.6)),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
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
                            "Étape 1 : Identification",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Nom complet
                          buildInputField(
                            "Nom complet",
                            nomCtrl,
                            Icons.person_outline,
                          ),

                          // Date de naissance
                          buildInputField(
                            "Date de naissance",
                            dateNaissanceCtrl,
                            Icons.calendar_today,
                          ),

                          // CIN / Passeport
                          buildInputField(
                            "CIN / Passeport",
                            cinCtrl,
                            Icons.badge_outlined,
                          ),

                          // Nationalité
                          buildInputField(
                            "Nationalité",
                            nationaliteCtrl,
                            Icons.flag_outlined,
                          ),

                          // Sexe
                          buildInputField("Sexe", sexeCtrl, Icons.wc),

                          // Adresse
                          buildInputField(
                            "Adresse actuelle",
                            adresseCtrl,
                            Icons.location_on_outlined,
                          ),

                          // Téléphone
                          buildInputField(
                            "Téléphone",
                            telCtrl,
                            Icons.phone_android,
                          ),

                          // Email
                          buildInputField(
                            "Email",
                            emailCtrl,
                            Icons.email_outlined,
                            inputType: TextInputType.emailAddress,
                          ),

                          const SizedBox(height: 20),

                          // Upload CIN
                          ElevatedButton.icon(
                            onPressed: _pickImage,
                            icon: Icon(Icons.upload_file, color: Colors.white),
                            label: Text(
                              "Téléverser la photo de la CIN",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          if (_imageCIN != null) ...[
                            const SizedBox(height: 10),
                            Image.file(
                              _imageCIN!,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ],

                          const SizedBox(height: 30),

                          // Bouton Suivant
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => Profil()),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              elevation: 4,
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.black54,
                            ),
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [attijariRed, attijariYellow],
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                constraints: BoxConstraints(
                                  minWidth: 150,
                                  minHeight: 50,
                                ),
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

  Widget buildInputField(
    String label,
    TextEditingController controller,
    IconData icon, {
    TextInputType inputType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        keyboardType: inputType,
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez entrer $label';
          }
          return null;
        },
      ),
    );
  }
}

// Champ spécial pour la date de naissance avec date picker
Widget buildDatePickerField(
  BuildContext context,
  TextEditingController controller,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Date de naissance",
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(Icons.calendar_today, color: Colors.white70),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer votre date de naissance';
        }
        return null;
      },
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime(2000),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          locale: const Locale('fr', 'FR'),
        );

        String formattedDate = "${pickedDate?.day.toString().padLeft(2, '0')}/"
            "${pickedDate?.month.toString().padLeft(2, '0')}/"
            "${pickedDate?.year.toString().substring(2)}";
        controller.text = formattedDate;
      },
    ),
  );
}
