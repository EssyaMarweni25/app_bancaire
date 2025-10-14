import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AjouterCarte extends StatefulWidget {
  const AjouterCarte({super.key});

  @override
  _AjouterCarteState createState() => _AjouterCarteState();
}

class _AjouterCarteState extends State<AjouterCarte> {
  String selectedCategory = 'Particuliers & Professions Libérales';
  int? selectedCardIndex;
  int? hoveredIndex;

  final _formKey = GlobalKey<FormState>();
  final List<String> cardTypes = [
    'Essentiel 18-25 ans',
    'Essentiel Club',
    'Essentiel Premium',
    'Essentiel Titanium',
    'e-pack Auto-entrepreneur',
    'e-pack Confort',
    'e-pack Premier',
    'PACK ELAN 18-25 GOLD',
    'PACK ELAN GOLD',
    'PACK ELAN PLATINIUM',
    'PACK ELAN SIGNATURE',
    'Autre'
  ];
  String? selectedCard;
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController holderController = TextEditingController();

  final Color attijariYellow = const Color(0xFFF4B500);
  final Color attijariRed = const Color(0xFFE2471C);

  final Map<String, List<Map<String, String>>> cartesParCategorie = {
    'Particuliers & Professions Libérales': [
      {
        'nom': 'Essentiel 18-25 ans',
        'image':
            'assets/carte/Particulier & Professions/Carte_ouverture_compte _18_25.jpg',
        'description': '''L'Essentiel des services bancaires pour les jeunes

                    La carte Visa 18-25 est une carte locale et internationale de retrait et de paiement contactless à débit immédiat.

                     Personnalisable depuis l'application Attijari Mobile avec :

                     - Des retraits sécurisés allant jusqu’à 5 000 dhs/jour  
                     - Des achats de biens et de services en toute sécurité, en point de vente ou en ligne, au Maroc ou à l’étranger allant jusqu’à 30 000 dhs/mois      
                     - Une assistance en cas de perte, vol ou dysfonctionnement de la carte'''
      },
      {
        'nom': 'Essentiel Club ',
        'image': 'assets/carte/Particulier & Professions/Essentiel_club.jpg',
        'description': '''L’essentiel à petit prix

              La carte Visa Club est une carte locale et internationale de retrait et de paiement contactless à débit immédiat.  

              Personnalisable depuis l'application Attijari Mobile avec : 

                    - Des retraits sécurisés allant jusqu’à  5 000 dhs/jour 
                    - Des achats de biens et de services en toute sécurité, en point de vente ou en ligne, au Maroc ou à l’étranger allant jusqu’à 30 000 dhs/mois 
                    - Une assistance en cas de perte, vol ou dysfonctionnement de la carte '''
      },
      {
        'nom': 'Essentiel Premium ',
        'image': 'assets/carte/Particulier & Professions/essentiel_premium.jpg',
        'description': '''Pack Premium à budget maitrisé 

La carte Visa Premium est une carte locale et internationale de retrait et de paiement contactless à débit immédiat.  

Personnalisable depuis l'application Attijari Mobile avec :  

    - Des retraits sécurisés allant jusqu’à  10 000 dhs/jour   
    - Des achats de biens et de services en toute sécurité, en point de vente ou en  
      ligne, au Maroc ou à l’étranger allant jusqu’à 40 000 dhs/mois
    - Une assistance en cas de perte, vol ou dysfonctionnement de la carte'''
      },
      {
        'nom': 'Essentiel Titanium',
        'image':
            'assets/carte/Particulier & Professions/Essentiel_titanium.jpg',
        'description': '''Pack haut de gamme à tarif exclusif

La carte Visa Titanium est une carte locale et internationale de retrait et de paiement contactless à débit immédiat.  

Personnalisable depuis l'application Attijari Mobile avec :  

    - Des retraits sécurisés allant jusqu’à 15 000 dhs/jour  
    - Des achats de biens et de services en toute sécurité, en point de vente ou en  
      ligne, au Maroc ou à l’étranger allant jusqu’à 50 000 dhs/mois    
    - Une assistance en cas de perte, vol ou dysfonctionnement de la carte '''
      },
    ],
    'Très Petites Entreprises': [
      {
        'nom': 'e-pack Auto-entrepreneur',
        'image': 'assets/carte/Petite entreprise/entreprneur.png',
        'description': '''De nombreux avantages à petits prix !

Auto-entrepreneurs, ce pack est fait pour vous ! Le e-pack Auto-entrepreneur vous propose un ensemble de produits et services pour une gestion optimale de votre compte :

Carte Rasmali Auto-entrepreneur, Visa, locale et contactless, de retrait et de paiement.
Personnalisable depuis l’application Attijari Mobile avec :

    - Des retraits sécurisés allant jusqu’à 5 000 DH/jour  
    - Des achats sécurisés en point de vente, en ligne, au Maroc et à l’étranger          
      allant jusqu’à 30 000 DH/mois 
    - Une assistance perte, vol ou dysfonctionnement de la carte'''
      },
      {
        'nom': 'e-pack Confort',
        'image': 'assets/carte/e_confort.png',
        'description': '''L’essentiel de la banque à petit prix !

Entrepreneurs, le e-pack confort vous propose une panoplie de produits et services pour une meilleure gestion de votre compte !
Carte Rasmali Confort, Visa, locale et contactless, de retrait et de paiement.
Personnalisable depuis l’application Attijari Mobile avec :

    - Des retraits sécurisés allant jusqu’à 10 000 DH/jour  
    - Des achats sécurisés en point de vente, en ligne, au Maroc et à l’étranger   
      allant jusqu’à 40 000 DH/mois 
    - Une assistance perte, vol ou dysfonctionnement de la carte'''
      },
      {
        'nom': 'e-pack Premier',
        'image': 'assets/carte/Petite entreprise/premier.png',
        'description': '''Une offre privilège à un budget maîtrisé !

Le e-pack Premier vous donne un accès privilégié à une carte internationale haut de gamme pour une gestion optimale de votre compte !

Carte Rasmali Premier, Visa, locale et internationale, contactless, de retrait et de paiement.
Personnalisable depuis l’application Attijari Mobile avec :

    - Des retraits sécurisés allant jusqu’à 15 000 DH/jour  
    - Des achats sécurisés en point de vente, en ligne, au Maroc et à l’étranger  
      allant jusqu’à 60 000 DH/mois 
    - Une assistance perte, vol ou dysfonctionnement de la carte'''
      },
    ],
    'Marocains du Monde': [
      {
        'nom': 'PACK ELAN 18-25 GOLD',
        'image': 'assets/carte/Marocains/pack_elan_gold_1.png',
        'description':
            '''Le PACK ELAN 18-25 GOLD vous propose tout ce dont vous avez besoin pour gérer votre compte, et bien plus encore.

    - Un compte chèque MDM en MAD 
    - Une carte Visa Gold pour effectuer vos retraits et paiements au Maroc et 
      à l'international 
    - La gestion de votre compte à distance et l’accès à une multitude de services 
      bancaires en ligne via l’application Attijari Mobile et le portail Attijarinet 
    - Un service de conseil juridique (e-sticharati) assuré par une équipe de juristes
     confirmés joignables par téléphone, pour répondre à toutes vos questions
     d’ordre juridique'''
      },
      {
        'nom': 'PACK ELAN GOLD',
        'image': 'assets/carte/Marocains/Pack_elan_gold.png',
        'description':
            '''Le PACK ELAN GOLD vous propose tout ce dont vous avez besoin pour gérer votre compte, et bien plus encore.

    - Un compte chèque MDM en MAD 
    - Une carte Visa Gold pour effectuer vos retraits et paiements au Maroc et 
      à l'international 
    - La gestion de votre compte à distance et l’accès à une multitude de services 
      bancaires en ligne via l’application Attijari Mobile et le portail Attijarinet 
    - Un service de conseil juridique (e-sticharati) assuré par une équipe de juristes 
     confirmés joignables par téléphone, pour répondre à toutes vos questions 
     d’ordre juridique'''
      },
      {
        'nom': 'PACK ELAN PLATINIUM',
        'image': 'assets/carte/Marocains/Pack_platinium.png',
        'description':
            '''Le PACK ELAN PLATINIUM vous propose tout ce dont vous avez besoin pour gérer votre compte, et bien plus encore.

    - Un compte chèque MDM en MAD 
    - Une carte Visa PLANITUM pour effectuer vos retraits et paiements au Maroc et 
      à l'international 
    - La gestion de votre compte à distance et l’accès à une multitude de services 
      bancaires en ligne via l’application Attijari Mobile et le portail Attijarinet 
    - Un service de conseil juridique (e-sticharati) assuré par une équipe de juristes 
      confirmés joignables par téléphone, pour répondre à toutes vos questions 
      d’ordre juridique'''
      },
      {
        'nom': 'PACK ELAN SIGNATURE',
        'image': 'assets/carte/Marocains/Pack_signature.png',
        'description':
            '''Le PACK ELAN SIGNATURE vous propose tout ce dont vous avez besoin pour gérer votre compte, et bien plus encore.

     - Un compte chèque MDM en MAD 
     - Une carte Visa SIGNATURE pour effectuer vos retraits et paiements au Maroc 
       et à l'international 
     - La gestion de votre compte à distance et l’accès à une multitude de services 
       bancaires en ligne via l’application Attijari Mobile et le portail Attijarinet 
    - Un service de conseil juridique (e-sticharati) assuré par une équipe de juristes 
      confirmés joignables par téléphone, pour répondre à toutes vos questions 
      d’ordre juridique'''
      },
    ],
    'Ajouter': [],
  };

  @override
  Widget build(BuildContext context) {
    final cartes = cartesParCategorie[selectedCategory]!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE2471C), Color(0xFFF4B500)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Ajouter une carte',
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: true,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Boutons de catégorie
              Container(
                color: attijariYellow,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: cartesParCategorie.keys.map((cat) {
                    //.where((cat) => cat != 'Ajouter')
                    //.map((cat) {
                    final isSelected = cat == selectedCategory;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ElevatedButton.icon(
                          icon: Icon(
                            cat == 'Particuliers & Professions Libérales'
                                ? Icons.person
                                : cat == 'Très Petites Entreprises'
                                    ? Icons.store
                                    : cat == 'Marocains du Monde'
                                        ? Icons.public
                                        : Icons.add,
                          ),
                          label: Text(
                            cat,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 10),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedCategory = cat;
                              selectedCardIndex = null;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isSelected ? attijariRed : Colors.white,
                            foregroundColor:
                                isSelected ? Colors.white : Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              // Bouton "Ajouter"
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _showAddCardForm(context),
                    icon: Icon(Icons.add),
                    label: Text('Ajouter'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: attijariRed,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),

              // // Bouton "Ajouter une nouvelle carte"
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: SizedBox(
              //     width: double.infinity,
              //     child: ElevatedButton.icon(
              //       onPressed: () => _showAddCardForm(context),
              //       icon: Icon(Icons.add),
              //       label: Text('Ajouter une nouvelle carte'),
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: attijariRed,
              //         foregroundColor: Colors.white,
              //         padding: EdgeInsets.symmetric(vertical: 15),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              SizedBox(height: 20),
              // Liste des cartes horizontale
              if (cartes.isNotEmpty) ...[
                Container(
                  height: 210,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cartes.length,
                    itemBuilder: (context, index) {
                      final carte = cartes[index];
                      final isHovered = hoveredIndex == index;
                      final isSelected = selectedCardIndex == index;

                      return MouseRegion(
                        onEnter: (_) => setState(() => hoveredIndex = index),
                        onExit: (_) => setState(() => hoveredIndex = null),
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => selectedCardIndex = index),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                            margin: EdgeInsets.only(right: 16),
                            transform: isHovered
                                ? (Matrix4.identity()..scale(1.05))
                                : Matrix4.identity(),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: isSelected
                                    ? attijariRed
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            width: 160,
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Image.asset(
                                    carte['image']!,
                                    //'assets/carte/atm-card.png',
                                    width: 150,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    carte['nom']!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Colors.black87,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ] else ...[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      'Aucune carte disponible dans cette catégorie.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ],

              // Description de la carte sélectionnée
              if (selectedCardIndex != null) ...[
                Divider(height: 30, thickness: 1, color: Colors.grey[300]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartes[selectedCardIndex!]['nom']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "L’essentiel à petit prix",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      SizedBox(height: 12),
                      Text(
                        cartes[selectedCardIndex!]['description']!,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddCardForm(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String? type;
    String? numero;
    String? expiry;
    String? cvv;
    String? titulaire;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Ajouter",
          style: TextStyle(color: attijariRed),
        ),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Type de carte",
                    border: OutlineInputBorder(),
                  ),
                  items: cardTypes
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => type = val,
                  validator: (val) => val == null || val.isEmpty
                      ? "Sélectionner un type"
                      : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Numéro de carte",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 16,
                  validator: (val) => val == null || val.length != 16
                      ? "Le numéro doit contenir 16 chiffres"
                      : null,
                  onSaved: (val) => numero = val,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Date d'expiration (MM/YY)",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.datetime,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Entrer la date d'expiration";
                    }
                    if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(val)) {
                      return "Format: MM/YY";
                    }
                    return null;
                  },
                  onSaved: (val) => expiry = val,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "CVV",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: 3,
                  validator: (val) => val == null || val.length != 3
                      ? "Le CVV doit contenir 3 chiffres"
                      : null,
                  onSaved: (val) => cvv = val,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Nom du titulaire",
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => val == null || val.isEmpty
                      ? "Le nom du titulaire est obligatoire"
                      : null,
                  onSaved: (val) => titulaire = val,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Annuler"),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();

                // Masquer le numéro de carte pour la sécurité
                String numeroMasque = '**** **** **** ${numero!.substring(12)}';

                setState(() {
                  cartesParCategorie[selectedCategory]!.add({
                    'nom': type!,
                    'image': 'assets/carte/atm-card.png',
                    'description':
                        'Carte personnalisée ajoutée par l\'utilisateur.',
                    'numero': numeroMasque,
                    'expiry': expiry!,
                    'cvv': cvv!,
                    'titulaire': titulaire!.toUpperCase(),
                  });
                });
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Carte ajoutée avec succès!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: attijariRed,
              foregroundColor: Colors.white,
            ),
            child: Text("Ajouter"),
          ),
        ],
      ),
    );
  }
}
