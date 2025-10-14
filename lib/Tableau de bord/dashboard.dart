import 'package:attijari_digital/Tableau%20de%20bord/ajoutercart.dart';
import 'package:attijari_digital/Tableau%20de%20bord/cash.dart';
import 'package:attijari_digital/Tableau%20de%20bord/compte_profil.dart';
import 'package:attijari_digital/Tableau%20de%20bord/depot.dart';
import 'package:attijari_digital/Tableau%20de%20bord/devise.dart';
import 'package:attijari_digital/Tableau%20de%20bord/epargne.dart';
import 'package:attijari_digital/Tableau%20de%20bord/plus.dart';
import 'package:attijari_digital/Tableau%20de%20bord/pret.dart';
import 'package:attijari_digital/Tableau%20de%20bord/rapport.dart';
import 'package:attijari_digital/home/chat.dart';
import 'package:flutter/material.dart';
import 'package:attijari_digital/Tableau%20de%20bord/transfer.dart';

class Dashboard extends StatefulWidget {
  final String prenom;
  final String nom;

  Dashboard({super.key, required this.prenom, required this.nom});

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
    {'bgImage': 'assets/carte/pack_elan_gold_1.png'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color.fromARGB(255, 68, 44, 10), Color(0xFFBC430D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          //  AppBar(
          //   backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            'Bonjour, ${widget.prenom} 👋',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                onTap: () {
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
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.blueGrey[900]),
                ),
              ),
            ),
          ],
        ),
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
              _buildServicesSection(context),
              SizedBox(height: 30)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const Chat()));
        },
        backgroundColor: widget.attijariRed,
        child: Icon(Icons.support_agent, color: Colors.white),
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
          )
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
        SizedBox(
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
                  onTap: () async {
                    final newCard = await Navigator.push<Map<String, String>>(
                        context,
                        //Navigator.push(context,
                        MaterialPageRoute(builder: (_) => AjouterCarte()));
                    if (newCard != null) {
                      setState(() {
                        accounts.add(newCard);
                      });
                    }
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

  Widget _buildServicesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text('Services',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _buildServiceItem(context, Icons.send, 'Transfert', Transfer()),
            _buildServiceItem(
                context, Icons.account_balance_wallet, 'Dépôt', Depot()),
            _buildServiceItem(context, Icons.account_balance, 'Prêt', Pret()),
            _buildServiceItem(
                context, Icons.card_giftcard, 'Cashback', Cashback()),
            _buildServiceItem(context, Icons.savings, 'Épargne', Epargne()),
            _buildServiceItem(
                context, Icons.currency_exchange, 'Devise', Devise()),
            _buildServiceItem(context, Icons.pie_chart, 'Rapport', Rapport()),
            _buildServiceItem(context, Icons.more_horiz, 'Plus', Plus()),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceItem(
      BuildContext context, IconData icon, String label, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
        // Ajoute navigation ici si besoin
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white, // fond blanc
              border: Border.all(
                color: Color(0xFFE2471C), // couleur du cadre
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12), // angles arrondis
            ),
            child: Icon(icon, color: Color(0xFFE2471C), size: 28),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 13, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
