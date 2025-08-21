import 'dart:ui';

import 'package:attijari_digital/ouvrir%20compte/identification.dart';
import 'package:flutter/material.dart';
import 'package:attijari_digital/home/login.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌁 Background flou
          Positioned.fill(
            child: Image.asset(
              'assets/attijari-bank.png',
              fit: BoxFit.cover,
            ),
          ),

          // 🌀 Couche sombre semi-transparente
          Container(
            color: Colors.black.withOpacity(0.6),
          ),

          // ✅ Contenu principal
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),

                  // 📇 Stack des cartes empilées
                  SizedBox(
                    height: 200,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 40,
                          left: 30,
                          child: _buildCard('assets/carte/e_confort.png', 240),
                        ),
                        Positioned(
                          top: 20,
                          right: 30,
                          child: _buildCard(
                              'assets/carte/essentiel_premium.jpg', 250),
                        ),
                        _buildCard('assets/carte/pack_elan_gold_1.png', 260),
                      ],
                    ),
                  ),

                  const SizedBox(height: 60),

                  Text(
                    'Gérez votre argent\navec facilité, sécurité\net élégance',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Une expérience bancaire fluide pensée pour vous',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const Spacer(),

                  // 🔘 Bouton
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigation vers la page WelcomeScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: StadiumBorder(),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFE2471C), Color(0xFFF4B500)],
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            'Rejoindre Attijari Bank',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String imagePath, double width) {
    return Container(
      width: width,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// Votre page WelcomeScreen
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 🌁 Image de fond
          Image.asset(
            'assets/attijari-bank.png',
            fit: BoxFit.cover,
          ),
          // 🌫 Flou
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              color: Colors.black.withOpacity(0.6), // overlay sombre
            ),
          ),
          // 🧾 Contenu principal
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),

                  // 📇 Stack des cartes empilées
                  SizedBox(
                    height: 200,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 40,
                          left: 30,
                          child: _buildCard('assets/carte/e_confort.png', 240),
                        ),
                        Positioned(
                          top: 20,
                          right: 30,
                          child: _buildCard(
                              'assets/carte/essentiel_premium.jpg', 250),
                        ),
                        _buildCard('assets/carte/pack_elan_gold_1.png', 260),
                      ],
                    ),
                  ),

                  const SizedBox(height: 60),

                  Text(
                    'Gérez votre argent\navec facilité, sécurité\net élégance',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    'Une expérience bancaire fluide pensée pour vous',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const Spacer(),

                  // 🔘 Bouton
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Identification(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: StadiumBorder(),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFE2471C), Color(0xFFF4B500)],
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            'Rejoindre Attijari Bank',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String imagePath, double width) {
    return Container(
      width: width,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
