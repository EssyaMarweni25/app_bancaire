import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

/// Page principale affichant la liste des cartes
class Carte extends StatefulWidget {
  @override
  _CarteState createState() => _CarteState();
}

class _CarteState extends State<Carte> {
  // Liste des cartes (maintenant modifiable)
  List<Map<String, String>> cards = [
    {
      "type": "Visa Classique",
      "num": "**** 1234",
      "statut": "Active",
      "holder": "Essya Marweni",
      "expiry": "12/26",
      "cvv": "123"
    },
    {
      "type": "Visa Gold",
      "num": "**** 2345",
      "statut": "Active",
      "holder": "Nom Prenom",
      "expiry": "08/25",
      "cvv": "456"
    },
    {
      "type": "Visa Platinum",
      "num": "**** 3456",
      "statut": "Bloquée",
      "holder": "Nom Prenom",
      "expiry": "11/24",
      "cvv": "789"
    },
    {
      "type": "MasterCard Classique",
      "num": "**** 4567",
      "statut": "Active",
      "holder": "Nom Prenom",
      "expiry": "09/26",
      "cvv": "321"
    },
    {
      "type": "MasterCard Gold",
      "num": "**** 5678",
      "statut": "Bloquée",
      "holder": "Said Ben Ali",
      "expiry": "01/27",
      "cvv": "654"
    },
    {
      "type": "Carte Prépayée",
      "num": "**** 6789",
      "statut": "Active",
      "holder": "Nadia Khelifi",
      "expiry": "03/25",
      "cvv": "987"
    },
    {
      "type": "Carte Professionnelle",
      "num": "**** 7890",
      "statut": "Active",
      "holder": "Khaled Zarrouk",
      "expiry": "07/26",
      "cvv": "147"
    },
  ];

  // Méthode pour ajouter une nouvelle carte
  void _addCard(Map<String, String> newCard) {
    setState(() {
      cards.add(newCard);
    });
  }

  // Méthode pour supprimer une carte
  void _deleteCard(int index) {
    setState(() {
      cards.removeAt(index);
    });
  }

  // Méthode pour changer le statut d'une carte
  void _toggleCardStatus(int index) {
    setState(() {
      cards[index]["statut"] =
          cards[index]["statut"] == "Active" ? "Bloquée" : "Active";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes Cartes"),
        backgroundColor: Color(0xFFF4B500),
        foregroundColor: Colors.white,
      ),
      body: cards.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.credit_card_off, size: 100, color: Colors.grey),
                  SizedBox(height: 20),
                  Text(
                    "Aucune carte enregistrée",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: cards.length,
              itemBuilder: (context, index) {
                final card = cards[index];
                return Card(
                  margin: EdgeInsets.all(12),
                  elevation: 4,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: card["statut"] == "Active"
                          ? Colors.green
                          : Colors.red,
                      child: Icon(
                        card["type"] == "Visa"
                            ? Icons.credit_card
                            : Icons.payment,
                        color: Colors.white,
                      ),
                    ),
                    title: Text("${card["type"]} - ${card["num"]}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Titulaire : ${card["holder"] ?? "Non spécifié"}"),
                        Text(
                          "Statut : ${card["statut"]}",
                          style: TextStyle(
                            color: card["statut"] == "Active"
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: "view",
                          child: Row(
                            children: [
                              Icon(Icons.visibility),
                              SizedBox(width: 8),
                              Text("Voir détails"),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: "toggle",
                          child: Row(
                            children: [
                              Icon(card["statut"] == "Active"
                                  ? Icons.block
                                  : Icons.check_circle),
                              SizedBox(width: 8),
                              Text(card["statut"] == "Active"
                                  ? "Bloquer"
                                  : "Activer"),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: "delete",
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red),
                              SizedBox(width: 8),
                              Text("Supprimer",
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                      onSelected: (value) {
                        switch (value) {
                          case "view":
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CarteDetailScreen(
                                  type: card["type"]!,
                                  number: card["num"]!,
                                  status: card["statut"]!,
                                  holder: card["holder"] ?? "Non spécifié",
                                  expiry: card["expiry"] ?? "12/26",
                                  cvv: card["cvv"] ?? "123",
                                ),
                              ),
                            );
                            break;
                          case "toggle":
                            _toggleCardStatus(index);
                            break;
                          case "delete":
                            _showDeleteConfirmation(context, index);
                            break;
                        }
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CarteFormScreen()),
          );
          if (result != null) {
            _addCard(result);
          }
        },
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: Text("Ajouter", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFFF4B500),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmer la suppression"),
        content: Text("Êtes-vous sûr de vouloir supprimer cette carte ?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Annuler"),
          ),
          TextButton(
            onPressed: () {
              _deleteCard(index);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Carte supprimée")),
              );
            },
            child: Text("Supprimer", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

/// Écran pour afficher les détails d'une carte bancaire
class CarteDetailScreen extends StatelessWidget {
  final String type;
  final String number;
  final String status;
  final String holder;
  final String expiry;
  final String cvv;

  CarteDetailScreen({
    required this.type,
    required this.number,
    required this.status,
    required this.holder,
    required this.expiry,
    required this.cvv,
  });

  @override
  Widget build(BuildContext context) {
    // Générer un numéro de carte plus réaliste pour l'affichage
    String displayNumber = _generateDisplayNumber();

    return Scaffold(
      appBar: AppBar(
        title: Text("Détails de la Carte"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Carte visuelle
            CreditCardWidget(
              cardNumber: displayNumber,
              expiryDate: expiry,
              cardHolderName: holder.toUpperCase(),
              cvvCode: cvv,
              showBackView: false,
              obscureCardNumber: false,
              obscureCardCvv: true,
              cardBgColor: _getCardColor(),
              isHolderNameVisible: true,
              height: 220,
              width: MediaQuery.of(context).size.width,
              animationDuration: Duration(milliseconds: 1000),
              onCreditCardWidgetChange: (brand) {},
            ),

            SizedBox(height: 30),

            // Informations détaillées
            Card(
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Informations de la carte",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    Divider(),
                    _buildInfoRow("Type", type),
                    _buildInfoRow("Numéro", number),
                    _buildInfoRow("Titulaire", holder),
                    _buildInfoRow("Expiration", expiry),
                    _buildInfoRow("Statut", status,
                        statusColor:
                            status == "Active" ? Colors.green : Colors.red),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Actions rapides
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Historique(cardNumber: number),
                      ),
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(content: Text("Fonctionnalité à venir")),
                    );
                  },
                  icon: Icon(Icons.history),
                  label: Text("Historique"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Parametres(cardNumber: number),
                      ),
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(content: Text("Fonctionnalité à venir")),
                    );
                  },
                  icon: Icon(Icons.settings),
                  label: Text("Paramètres"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? statusColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: statusColor ?? Colors.black87,
              fontWeight:
                  statusColor != null ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  String _generateDisplayNumber() {
    // Convertir le numéro masqué en numéro d'affichage
    if (number.contains("1234")) {
      return "4532 1234 5678 9012"; // Visa
    } else if (number.contains("5678")) {
      return "5425 2334 5678 9012"; // MasterCard
    }
    return "1234 5678 9012 3456";
  }

  Color _getCardColor() {
    switch (type.toLowerCase()) {
      case "visa classique":
        return Colors.blue.shade800;
      case "visa gold":
        return Colors.amber.shade700;
      case "visa platinum":
        return Colors.grey.shade700;
      case "mastercard classique":
        return Colors.red.shade700;
      case "mastercard gold":
        return Colors.orange.shade700;
      case "carte prépayée":
        return Colors.green.shade600;
      case "carte professionnelle":
        return Colors.purple.shade700;
      default:
        return Colors.teal;
    }
  }
}

/// Formulaire pour saisir une nouvelle carte
class CarteFormScreen extends StatefulWidget {
  @override
  _CarteFormScreenState createState() => _CarteFormScreenState();
}

class _CarteFormScreenState extends State<CarteFormScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var creditCardForm = CreditCardForm(
      formKey: formKey,
      onCreditCardModelChange: (model) {
        setState(() {
          cardNumber = model.cardNumber;
          expiryDate = model.expiryDate;
          cardHolderName = model.cardHolderName;
          cvvCode = model.cvvCode;
          isCvvFocused = model.isCvvFocused;
        });
      },
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cardHolderName: cardHolderName,
      cvvCode: cvvCode,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter une Carte"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Affichage dynamique de la carte
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              obscureCardNumber: false,
              obscureCardCvv: false,
              cardBgColor: _getCardColor(),
              isHolderNameVisible: true,
              height: 220,
              width: MediaQuery.of(context).size.width,
              animationDuration: Duration(milliseconds: 500),
              onCreditCardWidgetChange: (brand) {},
            ),

            //Formulaire de saisie
            Padding(
              padding: EdgeInsets.all(16),
              child: creditCardForm,
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // Instructions
                  Card(
                    color: Colors.blue.shade50,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.blue),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Tous les champs marqués d'un * sont obligatoires",
                              style: TextStyle(color: Colors.blue.shade700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Boutons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Annuler"),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _saveCard,
                          child: Text("Enregistrer"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveCard() {
    if (formKey.currentState!.validate()) {
      // Déterminer le type de carte
      String cardType = _getCardType(cardNumber);

      // Masquer le numéro de carte
      String maskedNumber = _maskCardNumber(cardNumber);

      // Créer la nouvelle carte
      Map<String, String> newCard = {
        "type": cardType,
        "num": maskedNumber,
        "statut": "Active",
        "holder": cardHolderName,
        "expiry": expiryDate,
        "cvv": cvvCode,
      };

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Carte enregistrée avec succès!"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context, newCard);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Veuillez remplir tous les champs obligatoires"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _getCardType(String number) {
    String cleanNumber = number.replaceAll(' ', '');
    if (cleanNumber.startsWith('4')) {
      return 'Visa';
    } else if (cleanNumber.startsWith('5') || cleanNumber.startsWith('2')) {
      return 'MasterCard';
    } else if (cleanNumber.startsWith('3')) {
      return 'American Express';
    }
    return 'Autre';
  }

  String _maskCardNumber(String number) {
    String cleanNumber = number.replaceAll(' ', '');
    if (cleanNumber.length >= 4) {
      return '**** ${cleanNumber.substring(cleanNumber.length - 4)}';
    }
    return number;
  }

  Color _getCardColor() {
    String cardType = _getCardType(cardNumber);
    switch (cardType) {
      case 'Visa':
        return Colors.deepPurple;
      case 'MasterCard':
        return Colors.orange;
      case 'American Express':
        return Colors.green;
      default:
        return Colors.teal;
    }
  }
}

class Historique extends StatelessWidget {
  final String cardNumber;

  Historique({required this.cardNumber});

  @override
  Widget build(BuildContext context) {
    // Données fictives d'exemple
    final List<Map<String, String>> transactions = [
      {
        "date": "2025-07-20",
        "description": "Supermarché",
        "montant": "-35.00 €"
      },
      {
        "date": "2025-07-18",
        "description": "Recharge mobile",
        "montant": "-15.00 €"
      },
      {
        "date": "2025-07-15",
        "description": "Virement reçu",
        "montant": "+200.00 €"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Historique de la carte"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final tx = transactions[index];
          return ListTile(
            leading: Icon(
              tx["montant"]!.startsWith('-')
                  ? Icons.remove_circle
                  : Icons.add_circle,
              color: tx["montant"]!.startsWith('-') ? Colors.red : Colors.green,
            ),
            title: Text(tx["description"]!),
            subtitle: Text(tx["date"]!),
            trailing: Text(
              tx["montant"]!,
              style: TextStyle(
                color:
                    tx["montant"]!.startsWith('-') ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}

class Parametres extends StatefulWidget {
  final String cardNumber;

  Parametres({required this.cardNumber});

  @override
  _ParametresState createState() => _ParametresState();
}

class _ParametresState extends State<Parametres> {
  bool notificationsEnabled = true;
  bool plafondLimite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paramètres de la carte"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text("Notifications de transaction"),
            subtitle: Text("Recevoir une notification pour chaque transaction"),
            value: notificationsEnabled,
            onChanged: (val) {
              setState(() {
                notificationsEnabled = val;
              });
            },
          ),
          SwitchListTile(
            title: Text("Activer le plafond journalier"),
            subtitle: Text("Limiter les dépenses à 500€/jour"),
            value: plafondLimite,
            onChanged: (val) {
              setState(() {
                plafondLimite = val;
              });
            },
          ),
          ListTile(
            title: Text("Modifier le code PIN"),
            leading: Icon(Icons.lock),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Fonctionnalité à venir")),
              );
            },
          ),
        ],
      ),
    );
  }
}
