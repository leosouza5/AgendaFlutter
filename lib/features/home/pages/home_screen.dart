import 'package:agenda/features/contato/pages/contato_screen.dart';
import 'package:agenda/features/home/components/contato.dart';
import 'package:agenda/features/home/model/agenda_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final agenda = context.watch<AgendaModel>();
    return Scaffold(
      backgroundColor: Color(0xFF213435),
      appBar: AppBar(
        title: Text(
          "Minha Agenda",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        backgroundColor: Color(0xFF213435),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ContatoScreen()));
        },
        backgroundColor: Color(0xFF648a64),
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: agenda.contatos.isEmpty
          ? Center(
              child: Text(
                "Nenhum contato cadastrado !",
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                final contato = agenda.contatos[index];
                return Contato(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContatoScreen(
                            edicao: true,
                            model: contato,
                          ),
                        ));
                  },
                  email: contato.email,
                  nome: contato.nome,
                  numero: contato.numero,
                );
              },
              itemCount: agenda.contatos.length,
            ),
    );
  }
}
