import 'package:flutter/material.dart';

class PaiementFacture extends StatefulWidget {
  const PaiementFacture({super.key});

  @override
  State<PaiementFacture> createState() => _PaiementFactureState();
}

class _PaiementFactureState extends State<PaiementFacture> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _factureTypes = [
    'Eau',
    'STEG',
    'Téléphone (Ooredoo)',
    'Téléphone (Tunicom)',
    'Téléphone (Orange)',
    'Internet',
  ];

  String? _selectedFactureType;
  String? _numeroClient;
  String? _montant;

  void _payer() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Paiement de $_montant DT pour $_selectedFactureType effectué avec succès.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );

      _formKey.currentState?.reset();
      setState(() {
        _selectedFactureType = null;
        _numeroClient = null;
        _montant = null;
      });
    }
  }

  String? _validateNumeroClient(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Veuillez entrer votre numéro client';
    }
    // Ajouter validations spécifiques selon type facture si besoin
    return null;
  }

  String? _validateMontant(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Veuillez entrer un montant';
    }
    final montant = double.tryParse(value.replaceAll(',', '.'));
    if (montant == null || montant <= 0) {
      return 'Veuillez entrer un montant valide (>0)';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paiement Facture'),
        backgroundColor: Colors.orange[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Type de facture',
                  border: OutlineInputBorder(),
                ),
                items: _factureTypes
                    .map(
                      (type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ),
                    )
                    .toList(),
                onChanged: (val) => setState(() => _selectedFactureType = val),
                initialValue: _selectedFactureType,
                validator: (value) =>
                    value == null ? 'Veuillez sélectionner un type' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Numéro client',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.confirmation_number),
                ),
                keyboardType: TextInputType.number,
                onChanged: (val) => _numeroClient = val,
                validator: _validateNumeroClient,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Montant (DT)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onChanged: (val) => _montant = val,
                validator: _validateMontant,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _payer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    'Payer la facture',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
