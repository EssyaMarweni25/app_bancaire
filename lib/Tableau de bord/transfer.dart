import 'package:flutter/material.dart';

class Transfer extends StatefulWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  _TransferState createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  final _formKey = GlobalKey<FormState>();

  String? beneficiary;
  String? amount;
  String? reason;

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      // Logique de virement ici, par ex. appel API

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Virement de $amount DT vers $beneficiary effectué avec succès."),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );

      // Reset form après validation
      _formKey.currentState?.reset();
      setState(() {
        beneficiary = null;
        amount = null;
        reason = null;
      });
    }
  }

  String? _validateBeneficiary(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Veuillez entrer le nom du bénéficiaire";
    }
    return null;
  }

  String? _validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Veuillez entrer un montant";
    }
    final parsed = double.tryParse(value.replaceAll(',', '.'));
    if (parsed == null || parsed <= 0) {
      return "Veuillez entrer un montant valide supérieur à 0";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Virement"),
        backgroundColor: Colors.orange[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Nom du bénéficiaire",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (val) => beneficiary = val,
                validator: _validateBeneficiary,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Montant (DT)",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onChanged: (val) => amount = val,
                validator: _validateAmount,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Motif (optionnel)",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.note),
                ),
                maxLines: 2,
                onChanged: (val) => reason = val,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[700],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    "Valider le virement",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
