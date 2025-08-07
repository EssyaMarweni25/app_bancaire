import 'package:attijari_digital/Tableau%20de%20bord/compte_profil.dart';
import 'package:attijari_digital/Tableau%20de%20bord/paiement.dart';
import 'package:attijari_digital/home/chat.dart';
import 'package:flutter/material.dart';
import 'package:attijari_digital/Tableau%20de%20bord/carte.dart';
import 'package:attijari_digital/Tableau%20de%20bord/transfer.dart';
import 'package:attijari_digital/Tableau%20de%20bord/historique_transfer.dart';
import 'package:attijari_digital/Tableau%20de%20bord/setting.dart';
import 'dart:ui' as ui;
import 'package:vector_math/vector_math_64.dart' as vmath;

class Dashboard extends StatefulWidget {
  final String prenom;
  final String nom;

  Dashboard({required this.prenom, required this.nom});

  final Color attijariYellow = const Color(0xFFF4B500);
  final Color attijariRed = const Color(0xFFE2471C);
  final Color glassColor = Colors.white.withOpacity(0.15);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool showBalance = true;
  final double solde = 15420.75;

  final List<Map<String, String>> accounts = [
    {'bgImage': 'assets/carte/e_confort.png'},
    {'bgImage': 'assets/carte/essentiel_premium.jpg'},
    {'bgImage': 'assets/carte/pack_elan_gold_1.png'},
  ];

  // AJOUT DE LA VARIABLE MANQUANTE
  final List<Map<String, String>> operations = [
    {'libelle': 'Virement reçu', 'montant': '+500.00 DT'},
    {'libelle': 'Paiement facture', 'montant': '-85.50 DT'},
    {'libelle': 'Retrait ATM', 'montant': '-200.00 DT'},
    {'libelle': 'Virement envoyé', 'montant': '-150.00 DT'},
    {'libelle': 'Dépôt chèque', 'montant': '+1200.00 DT'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Bonjour, ${widget.prenom} 👋',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: false,
      ),
      drawer: _buildDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSoldeCard(),
              SizedBox(height: 30),
              _buildCardList(),
              SizedBox(height: 30),
              _buildServicesSection(),
              SizedBox(height: 30),
              _buildOperationsRecente(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const Chat()));
        },
        child: Icon(Icons.support_agent, color: Colors.white),
        backgroundColor: widget.attijariRed,
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: widget.attijariYellow),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Profile(
                          prenom: widget.prenom,
                          nom: widget.nom,
                          email: 'exemple@mail.com',
                          telephone: '12345678',
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Text(
                      '${widget.prenom[0].toUpperCase()}${widget.nom[0].toUpperCase()}',
                      style: TextStyle(
                        color: widget.attijariRed,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Text('Bienvenue,',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                SizedBox(height: 4),
                Text('${widget.prenom} ${widget.nom}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Tableau de bord'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('Carte'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Carte()));
            },
          ),
          ListTile(
            leading: Icon(Icons.account_balance),
            title: Text('Virements'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const Transfer()));
            },
          ),
          ListTile(
            leading: Icon(Icons.account_balance_wallet),
            title: Text('Paiement'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const PaiementFacture()));
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Historique'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const HistoriqueTransfer()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Paramètre'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const Setting()));
            },
          ),
          ListTile(
            leading: Icon(Icons.support_agent),
            title: Text('Assistance'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const Chat()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Déconnexion'),
            onTap: () {
              // Action logout
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSoldeCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Votre solde', style: TextStyle(color: Colors.grey[600])),
                SizedBox(height: 8),
                Text(
                  showBalance ? '${solde.toStringAsFixed(2)} DT' : '•••••••',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                showBalance ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey[700],
              ),
              onPressed: () {
                setState(() {
                  showBalance = !showBalance;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tous les Cartes',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 12),
        Container(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: accounts.length + 1,
            itemBuilder: (context, index) {
              if (index < accounts.length) {
                final account = accounts[index];
                return Container(
                  width: 220,
                  margin: EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(account['bgImage']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => AjouterCarte()));
                  },
                  child: Container(
                    width: 220,
                    margin: EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, size: 40, color: Colors.black54),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Services',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _buildServiceItem(Icons.send, 'Transfert'),
            _buildServiceItem(Icons.account_balance_wallet, 'Dépôt'),
            _buildServiceItem(Icons.account_balance, 'Prêt'),
            _buildServiceItem(Icons.card_giftcard, 'Cashback'),
            _buildServiceItem(Icons.savings, 'Épargne'),
            _buildServiceItem(Icons.currency_exchange, 'Devise'),
            _buildServiceItem(Icons.pie_chart, 'Rapport'),
            _buildServiceItem(Icons.more_horiz, 'Plus'),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceItem(IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        // Ajoute navigation ici si besoin
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Icon(icon, color: Colors.black87),
          ),
          SizedBox(height: 8),
          Text(label,
              style: TextStyle(fontSize: 13, color: Colors.black87),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildOperationsRecente() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Opérations récentes',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 12),
        ListView.builder(
          itemCount: operations.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Icon(Icons.swap_horiz, color: Colors.blueAccent),
                title: Text(operations[index]['libelle']!),
                trailing: Text(
                  operations[index]['montant']!,
                  style: TextStyle(
                    color: operations[index]['montant']!.startsWith('+')
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class AjouterCarte extends StatefulWidget {
  @override
  _AjouterCarteState createState() => _AjouterCarteState();
}

class _AjouterCarteState extends State<AjouterCarte> {
  String selectedCategory = 'Particuliers & Professions Libérales';
  int? selectedCardIndex;
  int? hoveredIndex;

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
                                    : Icons.public,
                          ),
                          label: Text(
                            cat,
                            textAlign: TextAlign.center,
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

              SizedBox(height: 20),
              // Liste des cartes horizontale
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
                        onTap: () => setState(() => selectedCardIndex = index),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 250),
                          curve: Curves.easeOut,
                          margin: EdgeInsets.only(right: 16),
                          transform: isHovered
                              ? (vmath.Matrix4.identity()..scale(1.05))
                              : vmath.Matrix4.identity(),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color:
                                  isSelected ? attijariRed : Colors.transparent,
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
                                  width: 160,
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
}
