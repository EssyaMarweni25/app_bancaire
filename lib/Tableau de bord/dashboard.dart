// import 'package:attijari_digital/Tableau%20de%20bord/compte_profil.dart';
// import 'package:attijari_digital/Tableau%20de%20bord/paiement.dart';
// import 'package:attijari_digital/home/chat.dart';
// import 'package:flutter/material.dart';
// import 'package:attijari_digital/Tableau%20de%20bord/dashboard.dart';
// import 'package:attijari_digital/Tableau de bord/carte.dart';
// import 'package:attijari_digital/Tableau de bord/transfer.dart';
// import 'package:attijari_digital/Tableau de bord/historique_transfer.dart';
// import 'package:attijari_digital/Tableau de bord/setting.dart';

// class Dashboard extends StatefulWidget {
//   final String prenom;
//   final String nom;
//   Dashboard({required this.prenom, required this.nom});

//   final Color attijariYellow = const Color(0xFFF4B500);
//   final Color attijariRed = const Color(0xFFE2471C);
//   final Color glassColor = Colors.white.withOpacity(0.15);
//   // Dashboard({
//   //   required this.prenom,
//   //   required this.nom,
//   // });

//   //

//   @override
//   State<Dashboard> createState() => _dashboardState();
// }

// class _dashboardState extends State<Dashboard> {
//   bool showBalance = true;

//   final double solde = 15420.75;
//   final List<Map<String, String>> operations = [
//     {'libelle': 'Virement reçu', 'montant': '+300 DT'},
//     {'libelle': 'Paiement carte', 'montant': '-120.50 DT'},
//     {'libelle': 'Retrait DAB', 'montant': '-200 DT'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 1,
//         title: Text(
//           'Bonjour, ${widget.prenom} 👋',
//           style: TextStyle(color: Colors.black87),
//         ),
//         centerTitle: false,
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: BoxDecoration(color: widget.attijariYellow),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context); // Fermer le drawer
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => Profile(
//                             prenom: widget.prenom,
//                             nom: widget.nom,
//                             email: 'exemple@mail.com',
//                             telephone: '12345678',
//                           ),
//                         ),
//                       );
//                     },
//                     child: CircleAvatar(
//                       radius: 30,
//                       backgroundColor: Colors.white,
//                       child: Text(
//                         '${widget.prenom[0].toUpperCase()}${widget.nom[0].toUpperCase()}',
//                         style: TextStyle(
//                           color: widget.attijariRed,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 24,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 12),
//                   Text(
//                     'Bienvenue,',
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     '${widget.prenom} ${widget.nom}',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 19,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.dashboard),
//               title: Text('Tableau de bord'),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.credit_card),
//               title: Text('Carte'),
//               onTap: () {
//                 Navigator.pop(context); // Ferme le drawer
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (_) => Carte()), // Va vers l'interface Carte
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.account_balance),
//               title: Text('Virements'),
//               onTap: () {
//                 Navigator.pop(context); // Fermer drawer
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const Transfer()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.account_balance_wallet),
//               title: Text('Paiement'),
//               onTap: () {
//                 Navigator.pop(context); // Fermer drawer
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const PaiementFacture()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.history),
//               title: Text('Historique'),
//               onTap: () {
//                 Navigator.pop(context); // Fermer drawer
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const HistoriqueTransfer()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.settings),
//               title: Text('Paramètre'),
//               onTap: () {
//                 Navigator.pop(context); // Fermer drawer
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const Setting()),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.support_agent),
//               title: Text('Assistance'),
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => const Chat()));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.logout),
//               title: Text('Déconnexion'),
//               onTap: () {
//                 // Ajoute ici ton action de logout
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Solde
//             Card(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//               color: Colors.white,
//               elevation: 3,
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Votre solde',
//                             style: TextStyle(color: Colors.grey[600])),
//                         SizedBox(height: 8),
//                         Text(
//                           showBalance
//                               ? '${solde.toStringAsFixed(2)} DT'
//                               : '•••••••',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ],
//                     ),
//                     IconButton(
//                       icon: Icon(
//                         showBalance ? Icons.visibility_off : Icons.visibility,
//                         color: Colors.grey[700],
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           showBalance = !showBalance;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 30),

//             // Opérations récentes
//             Text(
//               'Opérations récentes',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 12),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: operations.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     child: ListTile(
//                       leading: Icon(Icons.swap_horiz, color: Colors.blueAccent),
//                       title: Text(operations[index]['libelle']!),
//                       trailing: Text(
//                         operations[index]['montant']!,
//                         style: TextStyle(
//                           color: operations[index]['montant']!.startsWith('+')
//                               ? Colors.green
//                               : Colors.red,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),

//       // Bouton chatbot

//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => const Chat()));
//           // Action vers chatbot
//         },
//         child: Container(
//           padding: EdgeInsets.all(12),
//           child: Icon(Icons.support_agent, color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
import 'package:attijari_digital/Tableau%20de%20bord/compte_profil.dart';
import 'package:attijari_digital/Tableau%20de%20bord/paiement.dart';
import 'package:attijari_digital/home/chat.dart';
import 'package:flutter/material.dart';
import 'package:attijari_digital/Tableau%20de%20bord/dashboard.dart';
import 'package:attijari_digital/Tableau de bord/carte.dart';
import 'package:attijari_digital/Tableau de bord/transfer.dart';
import 'package:attijari_digital/Tableau de bord/historique_transfer.dart';
import 'package:attijari_digital/Tableau de bord/setting.dart';

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

  final List<Map<String, String>> operations = [
    {'libelle': 'Virement reçu', 'montant': '+300 DT'},
    {'libelle': 'Paiement carte', 'montant': '-120.50 DT'},
    {'libelle': 'Retrait DAB', 'montant': '-200 DT'},
  ];

  final List<Map<String, String>> accounts = [
    {
      'name': 'Shopping',
      'balance': '1400.00 DT',
      'cardNumber': '3457',
      'bgImage': 'assets/e_confort.png',
    },
    {
      'name': 'Primary',
      'balance': '500.00 DT',
      'cardNumber': '3009',
      'bgImage': 'assets/essentiel_premium.jpg',
    },
    {
      'name': 'Primary',
      'balance': '500.00 DT',
      'cardNumber': '3009',
      'bgImage': 'assets/cartee.png',
    },
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
      drawer: Drawer(
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
                  Text(
                    'Bienvenue,',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${widget.prenom} ${widget.nom}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Tableau de bord'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: Text('Carte'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => Carte()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance),
              title: Text('Virements'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Transfer()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text('Paiement'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PaiementFacture()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Historique'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HistoriqueTransfer()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Paramètre'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Setting()),
                );
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Solde
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: Colors.white,
              elevation: 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Votre solde',
                            style: TextStyle(color: Colors.grey[600])),
                        SizedBox(height: 8),
                        Text(
                          showBalance
                              ? '${solde.toStringAsFixed(2)} DT'
                              : '•••••••',
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
            ),

            SizedBox(height: 30),

            // Cartes "All Accounts"
            Text(
              'Tous les Cartes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: accounts.length,
                itemBuilder: (context, index) {
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
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(account['name']!,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          Spacer(),
                          Text(account['balance']!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          SizedBox(height: 4),
                          Text('•••• ${account['cardNumber']}',
                              style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 30),

            // Opérations récentes
            Text(
              'Opérations récentes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: operations.length,
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
            ),
          ],
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
}
