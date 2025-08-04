import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  void _logout(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Déconnexion"),
        content: const Text("Voulez-vous vraiment vous déconnecter ?"),
        actions: [
          TextButton(
            child: const Text("Annuler"),
            onPressed: () => Navigator.pop(ctx),
          ),
          TextButton(
            child: const Text("Oui"),
            onPressed: () {
              Navigator.pop(ctx);
              _logout(context);
            },
          ),
        ],
      ),
    );
  }

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$message (non encore implémenté)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text(
          'Paramètres',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFB71C1C), // Rouge Attijari
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Compte',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ParamItem(
            icon: Icons.person,
            title: 'Profil',
            onTap: () {
              _showSnack(context, 'Profil');
              // Navigator.pushNamed(context, '/profil');
            },
          ),
          ParamItem(
            icon: Icons.lock,
            title: 'Sécurité',
            onTap: () {
              _showSnack(context, 'Sécurité');
              // Navigator.pushNamed(context, '/securite');
            },
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Préférences',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ParamItem(
            icon: Icons.language,
            title: 'Langue',
            onTap: () {
              _showSnack(context, 'Langue');
              // Navigator.pushNamed(context, '/langue');
            },
          ),
          ParamItem(
            icon: Icons.brightness_6,
            title: 'Mode sombre',
            trailing: Switch(
              value: false,
              onChanged: (val) {
                _showSnack(context, 'Mode sombre activé');
                // Ajouter logique du thème ici
              },
            ),
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Support',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ParamItem(
            icon: Icons.help_outline,
            title: 'Aide & FAQ',
            onTap: () {
              _showSnack(context, 'Aide & FAQ');
              // Navigator.pushNamed(context, '/aide');
            },
          ),
          ParamItem(
            icon: Icons.info_outline,
            title: 'À propos',
            onTap: () {
              _showSnack(context, 'À propos');
              // Navigator.pushNamed(context, '/apropos');
            },
          ),
          ParamItem(
            icon: Icons.logout,
            title: 'Se déconnecter',
            color: Colors.redAccent,
            onTap: () {
              _confirmLogout(context);
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class ParamItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? color;

  const ParamItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.trailing,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color ?? const Color(0xFFB71C1C)),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
