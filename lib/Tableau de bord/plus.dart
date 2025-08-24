import 'package:flutter/material.dart';

class Plus extends StatelessWidget {
  const Plus({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {'icon': Icons.receipt, 'label': 'Paiement factures'},
      {'icon': Icons.phone_android, 'label': 'Recharges téléphoniques'},
      {'icon': Icons.people, 'label': 'Gestion bénéficiaires'},
      {'icon': Icons.settings, 'label': 'Paramètres'},
      {'icon': Icons.help_outline, 'label': 'Aide & Support'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plus de services'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: services.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final service = services[index];
          return ListTile(
            leading: Icon(service['icon'] as IconData, color: Colors.blue),
            title: Text(service['label'] as String),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Ici tu peux ajouter la navigation vers la page correspondante
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('${service['label']} non encore implémenté')),
              );
            },
          );
        },
      ),
    );
  }
}
