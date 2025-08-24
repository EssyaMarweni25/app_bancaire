import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Rapport extends StatefulWidget {
  const Rapport({super.key});

  @override
  State<Rapport> createState() => _RapportState();
}

class _RapportState extends State<Rapport> {
  // Périodes disponibles en jours
  final Map<String, int> _periodes = {
    '7 jours': 7,
    '30 jours': 30,
    '90 jours': 90,
  };

  String _periodeChoisie = '30 jours';

  // Liste fictive des transactions (type = 'depense' ou 'revenu')
  final List<Map<String, dynamic>> _transactions = [
    {
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'libelle': 'Achat supermarché',
      'montant': 45.90,
      'type': 'depense',
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 3)),
      'libelle': 'Salaire',
      'montant': 1500.00,
      'type': 'revenu',
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 10)),
      'libelle': 'Facture internet',
      'montant': 30.00,
      'type': 'depense',
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 15)),
      'libelle': 'Vente occasion',
      'montant': 200.00,
      'type': 'revenu',
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 25)),
      'libelle': 'Essence',
      'montant': 60.00,
      'type': 'depense',
    },
  ];

  List<Map<String, dynamic>> get _transactionsFiltrees {
    final jours = _periodes[_periodeChoisie]!;
    final dateLimite = DateTime.now().subtract(Duration(days: jours));
    return _transactions.where((t) => t['date'].isAfter(dateLimite)).toList();
  }

  double get _totalDepenses {
    return _transactionsFiltrees
        .where((t) => t['type'] == 'depense')
        .fold(0.0, (sum, t) => sum + t['montant']);
  }

  double get _totalRevenus {
    return _transactionsFiltrees
        .where((t) => t['type'] == 'revenu')
        .fold(0.0, (sum, t) => sum + t['montant']);
  }

  double get _solde {
    return _totalRevenus - _totalDepenses;
  }

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rapport financier'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Choix de la période
            DropdownButton<String>(
              value: _periodeChoisie,
              items: _periodes.keys
                  .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                  .toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _periodeChoisie = val;
                  });
                }
              },
            ),

            const SizedBox(height: 16),

            // Résumé financier
            Card(
              color: Colors.blue.shade50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryItem('Dépenses', _totalDepenses, Colors.red),
                    _buildSummaryItem('Revenus', _totalRevenus, Colors.green),
                    _buildSummaryItem('Solde', _solde, Colors.blue),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              'Transactions récentes',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 8),

            Expanded(
              child: _transactionsFiltrees.isEmpty
                  ? const Center(
                      child: Text('Aucune transaction sur cette période'))
                  : ListView.builder(
                      itemCount: _transactionsFiltrees.length,
                      itemBuilder: (context, index) {
                        final t = _transactionsFiltrees[index];
                        final isDepense = t['type'] == 'depense';
                        return ListTile(
                          leading: Icon(
                            isDepense
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            color: isDepense ? Colors.red : Colors.green,
                          ),
                          title: Text(t['libelle']),
                          subtitle: Text(_dateFormat.format(t['date'])),
                          trailing: Text(
                            '${isDepense ? '-' : '+'}${t['montant'].toStringAsFixed(2)} €',
                            style: TextStyle(
                                color: isDepense ? Colors.red : Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, double montant, Color color) {
    return Column(
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 6),
        Text(
          '${montant.toStringAsFixed(2)} €',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: color),
        )
      ],
    );
  }
}
