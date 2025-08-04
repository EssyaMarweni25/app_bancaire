import 'package:flutter/material.dart';

class HistoriqueTransfer extends StatelessWidget {
  const HistoriqueTransfer({super.key});

  final List<Map<String, dynamic>> historique = const [
    {
      'date': '2025-07-28',
      'libelle': 'Paiement Supermarché',
      'montant': -45.75,
    },
    {
      'date': '2025-07-27',
      'libelle': 'Virement reçu',
      'montant': 250.00,
    },
    {
      'date': '2025-07-26',
      'libelle': 'Facture Électricité',
      'montant': -120.40,
    },
    {
      'date': '2025-07-25',
      'libelle': 'Salaire',
      'montant': 1500.00,
    },
  ];

  Color getMontantColor(double montant) {
    return montant >= 0
        ? const Color(0xFFD4AF37)
        : const Color(0xFFB71C1C); // Doré / Rouge foncé
  }

  IconData getIcon(double montant) {
    return montant >= 0 ? Icons.arrow_downward : Icons.arrow_upward;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // Couleur claire de fond
      appBar: AppBar(
        title: const Text(
          'Historique',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFB71C1C), // Rouge Attijari
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: historique.length,
        itemBuilder: (context, index) {
          final transaction = historique[index];
          final montant = transaction['montant'] as double;

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                radius: 22,
                backgroundColor: getMontantColor(montant).withOpacity(0.15),
                child: Icon(
                  getIcon(montant),
                  color: getMontantColor(montant),
                ),
              ),
              title: Text(
                transaction['libelle'],
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                transaction['date'],
                style: const TextStyle(color: Colors.grey),
              ),
              trailing: Text(
                '${montant >= 0 ? '+' : '-'} ${montant.abs().toStringAsFixed(2)} TND',
                style: TextStyle(
                  color: getMontantColor(montant),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
