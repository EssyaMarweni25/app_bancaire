import 'dart:ui';

import 'package:flutter/material.dart';
import 'connexion.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final _formKey = GlobalKey<FormState>();

  String? situationPro;
  final TextEditingController employeurCtrl = TextEditingController();
  final TextEditingController revenuCtrl = TextEditingController();
  String? objectifCompte;
  String? estResident;

  final Color attijariYellow = const Color(0xFFF4B500);
  final Color attijariRed = const Color(0xFFE2471C);
  final Color glassColor = Colors.white.withOpacity(0.15);

  final List<String> situations = [
    'Étudiant',
    'Salarié',
    'Entrepreneur',
    'Retraité',
    'Sans emploi'
  ];

  final List<String> objectifs = [
    'Salaire',
    'Épargne',
    'Transactions courantes',
    'Autre'
  ];

  final List<String> ouiNon = ['Oui', 'Non'];

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
                            "Étape 2 : Profil Client",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Situation professionnelle
                          buildDropdownField(
                            label: "Situation professionnelle",
                            value: situationPro,
                            items: situations,
                            onChanged: (val) =>
                                setState(() => situationPro = val),
                          ),

                          // Nom de l'employeur ou établissement
                          buildTextField(
                            controller: employeurCtrl,
                            label: "Employeur / Établissement",
                            icon: Icons.business_outlined,
                          ),

                          // Revenu mensuel
                          buildTextField(
                            controller: revenuCtrl,
                            label: "Revenu mensuel (TND)",
                            icon: Icons.attach_money,
                            inputType: TextInputType.number,
                          ),

                          // Objectif du compte
                          buildDropdownField(
                            label: "Objectif du compte",
                            value: objectifCompte,
                            items: objectifs,
                            onChanged: (val) =>
                                setState(() => objectifCompte = val),
                          ),

                          // Résidence fiscale
                          buildDropdownField(
                            label: "Résident fiscal en Tunisie ?",
                            value: estResident,
                            items: ouiNon,
                            onChanged: (val) =>
                                setState(() => estResident = val),
                          ),

                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  situationPro != null &&
                                  objectifCompte != null &&
                                  estResident != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ConnexionEtBiometrie()),
                                );
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

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez entrer $label';
          }
          return null;
        },
      ),
    );
  }

  Widget buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        style: TextStyle(color: Colors.white),
        dropdownColor: Colors.black87,
        iconEnabledColor: Colors.white70,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: onChanged,
        validator: (val) =>
            val == null || val.isEmpty ? 'Veuillez sélectionner $label' : null,
      ),
    );
  }
}
