import 'package:flutter/material.dart';
import 'dart:math';

class Pret extends StatefulWidget {
  const Pret({super.key});

  @override
  State<Pret> createState() => _PretState();
}

class _PretState extends State<Pret> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _montantController = TextEditingController();
  final TextEditingController _dureeController = TextEditingController();
  final TextEditingController _tauxController = TextEditingController();

  bool _isSubmitting = false;
  double? _mensualite;

  // Liste fictive de prêts en cours
  final List<Map<String, dynamic>> _pretsEnCours = [
    {
      'libelle': 'Prêt Auto',
      'montant': 15000,
      'taux': 4.5,
      'duree': 36,
    },
    {
      'libelle': 'Prêt Immobilier',
      'montant': 120000,
      'taux': 3.2,
      'duree': 180,
    },
  ];

  @override
  void dispose() {
    _montantController.dispose();
    _dureeController.dispose();
    _tauxController.dispose();
    super.dispose();
  }

  void _calculerMensualite() {
    final montant = double.tryParse(_montantController.text) ?? 0;
    final duree = int.tryParse(_dureeController.text) ?? 0;
    final taux = double.tryParse(_tauxController.text) ?? 0;

    if (montant <= 0 || duree <= 0 || taux <= 0) return;

    final tauxMensuel = taux / 100 / 12;
    final mensualite =
        montant * tauxMensuel / (1 - pow(1 + tauxMensuel, -duree));

    setState(() {
      _mensualite = mensualite;
    });
  }

  Future<void> _soumettreDemande() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(seconds: 2)); // simulation appel API
    setState(() => _isSubmitting = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Demande de prêt soumise avec succès !')),
    );

    // Réinitialiser le formulaire
    _montantController.clear();
    _dureeController.clear();
    _tauxController.clear();
    setState(() {
      _mensualite = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Prêts'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Prêts en cours',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ..._pretsEnCours.map((pret) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.account_balance),
                    title: Text(pret['libelle']),
                    subtitle: Text(
                        'Montant : ${pret['montant']} €\nTaux : ${pret['taux']}% - Durée : ${pret['duree']} mois'),
                  ),
                )),
            const Divider(height: 32),
            Text('Nouvelle demande de prêt',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _montantController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Montant du prêt (€)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      final val = double.tryParse(v ?? '');
                      if (val == null || val <= 0) {
                        return 'Entrez un montant valide';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _dureeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Durée (mois)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      final val = int.tryParse(v ?? '');
                      if (val == null || val <= 0) {
                        return 'Entrez une durée valide';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _tauxController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Taux d\'intérêt annuel (%)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      final val = double.tryParse(v ?? '');
                      if (val == null || val <= 0) {
                        return 'Entrez un taux valide';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: _calculerMensualite,
                    child: const Text('Simuler mensualité'),
                  ),
                  if (_mensualite != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Mensualité estimée : ${_mensualite!.toStringAsFixed(2)} €',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _isSubmitting ? null : _soumettreDemande,
                    icon: _isSubmitting
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.send),
                    label: const Text('Soumettre la demande'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
