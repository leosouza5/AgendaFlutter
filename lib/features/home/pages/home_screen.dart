import 'package:agenda/features/contato/controller/contato_controller.dart';
import 'package:agenda/features/contato/pages/contato_screen.dart';
import 'package:agenda/features/home/components/contato.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<ContatoController>().recuperaContato();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final agenda = context.watch<ContatoController>();
    return Scaffold(
      backgroundColor: const Color(0xFF213435),
      appBar: AppBar(
        title: const Text(
          "Minha Agenda",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        backgroundColor: const Color(0xFF213435),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ContatoScreen()));
        },
        backgroundColor: const Color(0xFF648a64),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: () => agenda.recuperaContato(),
        child: agenda.listaDeContatos.isEmpty
            ? const Center(
                child: Text(
                  "Nenhum contato cadastrado !",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  final contato = agenda.listaDeContatos[index];
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
                itemCount: agenda.listaDeContatos.length,
              ),
      ),
    );
  }
}
