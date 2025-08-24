import 'package:flutter/material.dart';

class Cashback extends StatefulWidget {
  const Cashback({super.key});

  @override
  State<Cashback> createState() => _CashbackState();
}

class _CashbackState extends State<Cashback> {
  double _totalCashback = 48.75; // montant cumulé fictif

  // Liste fictive des transactions avec cashback
  final List<Map<String, dynamic>> _transactions = [
    {
      'marchand': 'Supermarché Carrefour',
      'montant': 80.50,
      'cashback': 2.40,
      'date': '02/08/2025'
    },
    {
      'marchand': 'Amazon',
      'montant': 150.00,
      'cashback': 4.50,
      'date': '30/07/2025'
    },
    {
      'marchand': 'Zara',
      'montant': 65.00,
      'cashback': 1.95,
      'date': '25/07/2025'
    },
  ];

  // Liste fictive des partenaires
  final List<Map<String, String>> _partenaires = [
    {'nom': 'Carrefour', 'logo': '🛒'},
    {'nom': 'Amazon', 'logo': '📦'},
    {'nom': 'Zara', 'logo': '👗'},
    {'nom': 'Fnac', 'logo': '📚'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cashback'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Solde Cashback
            Card(
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.card_giftcard,
                        size: 40, color: Colors.green),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Total Cashback',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(
                          '${_totalCashback.toStringAsFixed(2)} €',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            Text('Dernières transactions',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ..._transactions.map((t) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.shopping_bag),
                    title: Text(t['marchand']),
                    subtitle: Text('${t['montant']} € - le ${t['date']}'),
                    trailing: Text(
                      '+${t['cashback']} €',
                      style: const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                )),

            const Divider(height: 32),
            Text('Partenaires Cashback',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: _partenaires.map((p) {
                return Card(
                  color: Colors.blue.shade50,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(p['logo']!, style: const TextStyle(fontSize: 30)),
                        const SizedBox(height: 6),
                        Text(p['nom']!,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
