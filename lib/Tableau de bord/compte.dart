import 'package:flutter/material.dart';

class Compte extends StatelessWidget {
  final List<Map<String, String>> accounts = [
    {
      "type": "Compte Courant",
      "iban": "TN59 1234 **** 5678",
      "solde": "10 200 TND"
    },
    {
      "type": "Compte Épargne",
      "iban": "TN59 9876 **** 4321",
      "solde": "5 200 TND"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mes Comptes")),
      body: ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          final account = accounts[index];
          return Card(
            margin: EdgeInsets.all(12),
            child: ListTile(
              title: Text(account["type"]!),
              subtitle: Text(account["iban"]!),
              trailing: Text(account["solde"]!,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          );
        },
      ),
    );
  }
}
