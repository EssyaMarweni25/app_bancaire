import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// void main() {
//   runApp(const DepotApp());
// }

// class DepotApp extends StatelessWidget {
//   const DepotApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Service Dépôt',
//       theme: ThemeData(
//         primarySwatch: Colors.indigo,
//       ),
//       home: const Depot(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

class Depot extends StatefulWidget {
  const Depot({super.key});

  @override
  State<Depot> createState() => _DepotState();
}

class _DepotState extends State<Depot> {
  final _formKey = GlobalKey<FormState>();

  // Champs du formulaire
  String _depotSur = 'mon_compte'; // 'mon_compte' ou 'tiers'
  String _methode = 'en_ligne'; // 'en_ligne' ou 'en_agence'
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _compteController = TextEditingController();
  final TextEditingController _montantController = TextEditingController();
  final TextEditingController _refController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  bool _isSubmitting = false;

  // Formatage du montant
  String formatCurrency(String value) {
    try {
      final number = double.parse(value.replaceAll(',', '.'));
      final formatter =
          NumberFormat.simpleCurrency(locale: 'fr_FR', name: 'EUR');
      return formatter.format(number);
    } catch (e) {
      return value;
    }
  }

  @override
  void dispose() {
    _nomController.dispose();
    _compteController.dispose();
    _montantController.dispose();
    _refController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  // Simulation d'appel API pour effectuer le dépôt.
  Future<bool> _submitDepot(Map<String, dynamic> payload) async {
    setState(() => _isSubmitting = true);
    // Simule une requête réseau
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isSubmitting = false);

    // Ici vous feriez un POST HTTP vers votre backend :
    // final response = await http.post(Uri.parse('https://api.votrebanque/depots'), body: jsonEncode(payload));
    // return response.statusCode == 200;
    //
    // Pour l'exemple, on retourne true si montant < 1 000 000 (contrôle fictif)
    final montant = (payload['montant'] as double? ?? 0);
    if (montant <= 1000000) return true;
    return false;
  }

  void _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    // Préparer le payload
    final payload = <String, dynamic>{
      'depotSur': _depotSur,
      'methode': _methode,
      'nom': _nomController.text.trim(),
      'compte': _compteController.text.trim(),
      'montant': double.parse(_montantController.text.replaceAll(',', '.')),
      'reference': _refController.text.trim(),
      'note': _noteController.text.trim(),
      'date': DateTime.now().toIso8601String(),
    };

    // Afficher un récapitulatif et demander confirmation
    final montantFormat = formatCurrency(_montantController.text);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmer le dépôt'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Déposer sur : ${_depotSur == 'mon_compte' ? 'Mon compte' : 'Compte tiers'}'),
            const SizedBox(height: 6),
            Text(
                'Méthode : ${_methode == 'en_ligne' ? 'En ligne' : 'En agence'}'),
            const SizedBox(height: 6),
            Text('Nom : ${_nomController.text}'),
            const SizedBox(height: 6),
            Text('Compte : ${_compteController.text}'),
            const SizedBox(height: 6),
            Text('Montant : $montantFormat'),
            if (_refController.text.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text('Référence : ${_refController.text}'),
            ],
            if (_noteController.text.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text('Note : ${_noteController.text}'),
            ],
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Annuler')),
          ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Confirmer')),
        ],
      ),
    );

    if (confirm != true) return;

    // Appel du service (simulation)
    final success = await _submitDepot(payload);
    if (mounted) {
      if (success) {
        // Vidage des champs
        _formKey.currentState!.reset();
        _nomController.clear();
        _compteController.clear();
        _montantController.clear();
        _refController.clear();
        _noteController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Dépôt effectué avec succès !'),
            backgroundColor: Colors.green.shade700,
            duration: const Duration(seconds: 3),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                const Text('Échec du dépôt — veuillez réessayer plus tard.'),
            backgroundColor: Colors.red.shade700,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  // Validation du compte — exemple basique : 8-20 chiffres
  String? _validateAccount(String? v) {
    if (v == null || v.trim().isEmpty) return 'Le numéro de compte est requis';
    final s = v.trim();
    final digitsOnly = RegExp(r'^[0-9]+$');
    if (!digitsOnly.hasMatch(s))
      return 'Le numéro de compte doit contenir seulement des chiffres';
    if (s.length < 8 || s.length > 20)
      return 'Le numéro de compte doit faire 8 à 20 chiffres';
    return null;
  }

  String? _validateName(String? v) {
    if (v == null || v.trim().isEmpty) return 'Le nom est requis';
    if (v.trim().length < 2) return 'Le nom est trop court';
    return null;
  }

  String? _validateAmount(String? v) {
    if (v == null || v.trim().isEmpty) return 'Le montant est requis';
    final s = v.replaceAll(',', '.');
    final number = double.tryParse(s);
    if (number == null) return 'Entrez un montant valide (ex : 1000.50)';
    if (number <= 0) return 'Le montant doit être supérieur à 0';
    if (number > 10000000) return 'Montant trop élevé';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isBusy = _isSubmitting;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dépôt d\'argent'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 4),
                    // Choix Mon compte / Tiers
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('Mon compte'),
                            value: 'mon_compte',
                            groupValue: _depotSur,
                            onChanged: (v) => setState(() => _depotSur = v!),
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('Compte tiers'),
                            value: 'tiers',
                            groupValue: _depotSur,
                            onChanged: (v) => setState(() => _depotSur = v!),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Méthode
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('En ligne'),
                            value: 'en_ligne',
                            groupValue: _methode,
                            onChanged: (v) => setState(() => _methode = v!),
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('En agence'),
                            value: 'en_agence',
                            groupValue: _methode,
                            onChanged: (v) => setState(() => _methode = v!),
                          ),
                        ),
                      ],
                    ),

                    const Divider(height: 20),

                    // Nom du titulaire (si tiers, le nom du bénéficiaire)
                    TextFormField(
                      controller: _nomController,
                      decoration: InputDecoration(
                        labelText: _depotSur == 'mon_compte'
                            ? 'Votre nom'
                            : 'Nom du bénéficiaire',
                        prefixIcon: const Icon(Icons.person),
                        border: const OutlineInputBorder(),
                      ),
                      validator: _validateName,
                    ),

                    const SizedBox(height: 12),

                    // Numéro de compte
                    TextFormField(
                      controller: _compteController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Numéro de compte',
                        hintText: 'Entrez le numéro de compte (chiffres)',
                        prefixIcon: Icon(Icons.account_balance),
                        border: OutlineInputBorder(),
                      ),
                      validator: _validateAccount,
                    ),

                    const SizedBox(height: 12),

                    // Montant
                    TextFormField(
                      controller: _montantController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Montant',
                        hintText: 'Ex : 1500.50',
                        prefixIcon: Icon(Icons.euro),
                        border: OutlineInputBorder(),
                      ),
                      validator: _validateAmount,
                    ),

                    const SizedBox(height: 12),

                    // Référence (optionnel)
                    TextFormField(
                      controller: _refController,
                      decoration: const InputDecoration(
                        labelText: 'Référence (optionnel)',
                        prefixIcon: Icon(Icons.note),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Note (optionnel)
                    TextFormField(
                      controller: _noteController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Note (optionnel)',
                        prefixIcon: Icon(Icons.comment),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Boutons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: isBusy
                                ? const SizedBox.shrink()
                                : const Icon(Icons.send),
                            label: isBusy
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2, color: Colors.white))
                                : const Text('Effectuer le dépôt'),
                            onPressed: isBusy ? null : _onSubmit,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Info / aide
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Info : vous pouvez déposer via nos services numériques ou en agence. Les dépôts en agence peuvent nécessiter une pièce d\'identité.',
                        style: TextStyle(
                            color: Colors.grey.shade700, fontSize: 13),
                      ),
                    ),

                    const SizedBox(height: 8),
                    // Exemple d'historique fictif (optionnel)
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.history),
                      title: const Text('Historique (exemple)'),
                      subtitle: const Text('Aucun dépôt récent'),
                      trailing: IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Historique mis à jour (simulation)')));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
