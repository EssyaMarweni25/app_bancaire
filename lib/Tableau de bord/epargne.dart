import 'package:flutter/material.dart';

class Epargne extends StatefulWidget {
  const Epargne({super.key});

  @override
  State<Epargne> createState() => _EpargneState();
}

class _EpargneState extends State<Epargne> {
  // Liste fictive de comptes d’épargne
  final List<Map<String, dynamic>> _comptes = [
    {
      'nom': 'Livret A',
      'solde': 2500.75,
      'taux': 3.0,
      'evolution': [
        2000,
        2100,
        2300,
        2400,
        2500,
        2500
      ], // valeurs mensuelles fictives
    },
    {
      'nom': 'PEL',
      'solde': 8000.00,
      'taux': 2.5,
      'evolution': [7500, 7600, 7800, 7900, 8000, 8000],
    },
  ];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _montantController = TextEditingController();

  bool _isAdding = false;

  void _ajouterCompte() {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _comptes.add({
        'nom': _nomController.text,
        'solde': double.parse(_montantController.text),
        'taux': 1.5,
        'evolution': [double.parse(_montantController.text)],
      });
      _nomController.clear();
      _montantController.clear();
      _isAdding = false;
    });
  }

  Widget _buildEvolutionGraph(List<double> evolution) {
    final maxVal = evolution.reduce((a, b) => a > b ? a : b);

    return Row(
      children: evolution.map((val) {
        final width = (val / maxVal) * 100;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: width,
          height: 8,
          decoration: BoxDecoration(
            color: Colors.blue.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    _nomController.dispose();
    _montantController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Comptes d\'Épargne'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _comptes.length,
                itemBuilder: (context, index) {
                  final compte = _comptes[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(compte['nom']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Solde: ${compte['solde'].toStringAsFixed(2)} €'),
                          Text('Taux: ${compte['taux']} %'),
                          const SizedBox(height: 6),
                          _buildEvolutionGraph(
                              List<double>.from(compte['evolution'])),
                        ],
                      ),
                      leading: const Icon(Icons.savings, color: Colors.blue),
                    ),
                  );
                },
              ),
            ),
            if (_isAdding)
              Card(
                elevation: 4,
                margin: const EdgeInsets.only(top: 16),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nomController,
                          decoration: const InputDecoration(
                            labelText: 'Nom du compte d’épargne',
                            border: OutlineInputBorder(),
                          ),
                          validator: (v) =>
                              (v == null || v.isEmpty) ? 'Champ requis' : null,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _montantController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Montant initial (€)',
                            border: OutlineInputBorder(),
                          ),
                          validator: (v) {
                            final val = double.tryParse(v ?? '');
                            if (val == null || val <= 0) {
                              return 'Montant valide requis';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () =>
                                  setState(() => _isAdding = false),
                              child: const Text('Annuler'),
                            ),
                            ElevatedButton(
                              onPressed: _ajouterCompte,
                              child: const Text('Ajouter'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            else
              ElevatedButton.icon(
                onPressed: () => setState(() => _isAdding = true),
                icon: const Icon(Icons.add),
                label: const Text('Ouvrir un nouveau compte d’épargne'),
              ),
          ],
        ),
      ),
    );
  }
}
