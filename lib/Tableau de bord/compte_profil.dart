import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final String prenom;
  final String nom;
  final String email;
  final String telephone;
  final String? avatarPath;

  const Profile({
    Key? key,
    required this.prenom,
    required this.nom,
    required this.email,
    required this.telephone,
    this.avatarPath,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late TextEditingController _prenomController;
  late TextEditingController _nomController;
  late TextEditingController _emailController;
  late TextEditingController _telController;

  bool editMode = false;

  @override
  void initState() {
    super.initState();
    _prenomController = TextEditingController(text: widget.prenom);
    _nomController = TextEditingController(text: widget.nom);
    _emailController = TextEditingController(text: widget.email);
    _telController = TextEditingController(text: widget.telephone);
  }

  @override
  void dispose() {
    _prenomController.dispose();
    _nomController.dispose();
    _emailController.dispose();
    _telController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fullName = '${_prenomController.text} ${_nomController.text}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil de Compte'),
        backgroundColor: Color(0xFFF4B500),
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: widget.avatarPath != null
                  ? ClipOval(
                      child: Image.asset(
                        widget.avatarPath!,
                        fit: BoxFit.cover,
                        width: 36,
                        height: 36,
                      ),
                    )
                  : Icon(Icons.person, color: Colors.blueGrey[900]),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: widget.avatarPath != null
                            ? AssetImage(widget.avatarPath!)
                            : null,
                        child: widget.avatarPath == null
                            ? Text(
                                fullName
                                    .split(' ')
                                    .map((e) =>
                                        e.isNotEmpty ? e[0].toUpperCase() : '')
                                    .join(),
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey,
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        fullName,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Text('Compte Professionnel • Entreprise'),
                    ],
                  ),
                ),
                const Divider(height: 30, thickness: 1),
                editMode
                    ? Column(
                        children: [
                          _buildEditableField('Prénom', _prenomController),
                          _buildEditableField('Nom', _nomController),
                          _buildEditableField('Email', _emailController),
                          _buildEditableField('Téléphone', _telController),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                icon: const Icon(Icons.save),
                                label: const Text('Enregistrer'),
                                onPressed: () {
                                  setState(() {
                                    editMode = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Profil mis à jour !')),
                                  );
                                },
                              ),
                              const SizedBox(width: 12),
                              OutlinedButton(
                                child: const Text('Annuler'),
                                onPressed: () {
                                  setState(() {
                                    editMode = false;
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      )
                    : Column(
                        children: [
                          _buildInfoRow('Email', _emailController.text),
                          _buildInfoRow('Téléphone', _telController.text),
                        ],
                      ),
                const SizedBox(height: 24),
                if (!editMode)
                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.edit),
                      label: const Text('Modifier'),
                      onPressed: () {
                        setState(() {
                          editMode = true;
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(color: Colors.blueGrey),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          isDense: true,
        ),
      ),
    );
  }
}
