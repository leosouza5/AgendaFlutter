import 'package:flutter/material.dart';

class Contato extends StatelessWidget {
  final String nome;
  final String numero;
  final String email;
  final void Function()? onTap;
  const Contato({super.key, required this.nome, required this.numero, required this.email, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: const Color(0xFF648a64),
        textColor: Colors.white,
        iconColor: Colors.white,
        onTap: onTap,
        title: Text(
          nome,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              numero,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              email,
              style: const TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        trailing: const Icon(Icons.edit, size: 30),
        leading: const Icon(Icons.person, size: 30),
      ),
    );
  }
}
