import 'package:flutter/material.dart';

class Devise extends StatefulWidget {
  const Devise({super.key});

  @override
  State<Devise> createState() => _DeviseState();
}

class _DeviseState extends State<Devise> {
  // Taux de change statiques (par rapport à l’euro)
  final Map<String, double> _tauxChange = {
    'USD': 1.10,
    'EUR': 1.00,
    'GBP': 0.88,
    'JPY': 148.50,
    'CHF': 0.97,
  };

  String _fromDevise = 'EUR';
  String _toDevise = 'USD';
  double _montant = 1;
  double _resultatConversion = 1.10;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _montantController =
      TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    _calculateConversion();
  }

  void _calculateConversion() {
    final fromRate = _tauxChange[_fromDevise] ?? 1;
    final toRate = _tauxChange[_toDevise] ?? 1;
    setState(() {
      _resultatConversion = (_montant / fromRate) * toRate;
    });
  }

  void _onConvert() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _montant = double.parse(_montantController.text);
        _calculateConversion();
      });
    }
  }

  void _onAchat() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Achat de devises'),
          content: Text(
              'Vous avez acheté ${_montant.toStringAsFixed(2)} $_fromDevise pour ${_resultatConversion.toStringAsFixed(2)} $_toDevise.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _montantController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final devises = _tauxChange.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devises & Conversion'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Taux de change (par rapport à EUR)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              children: _tauxChange.entries.map((e) {
                return Chip(
                  label: Text('${e.key}: ${e.value.toStringAsFixed(4)}'),
                );
              }).toList(),
            ),
            const Divider(height: 32),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Conversion'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: _fromDevise,
                          decoration: const InputDecoration(
                            labelText: 'De',
                            border: OutlineInputBorder(),
                          ),
                          items: devises
                              .map((d) => DropdownMenuItem(
                                    value: d,
                                    child: Text(d),
                                  ))
                              .toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _fromDevise = val;
                                _calculateConversion();
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: _toDevise,
                          decoration: const InputDecoration(
                            labelText: 'Vers',
                            border: OutlineInputBorder(),
                          ),
                          items: devises
                              .map((d) => DropdownMenuItem(
                                    value: d,
                                    child: Text(d),
                                  ))
                              .toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _toDevise = val;
                                _calculateConversion();
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _montantController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Montant',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) {
                      final val = double.tryParse(v ?? '');
                      if (val == null || val <= 0) {
                        return 'Entrez un montant valide';
                      }
                      return null;
                    },
                    onChanged: (v) {
                      if (double.tryParse(v) != null) {
                        _montant = double.parse(v);
                        _calculateConversion();
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Résultat : ${_resultatConversion.toStringAsFixed(2)} $_toDevise',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text('Acheter cette devise'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _onAchat();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
