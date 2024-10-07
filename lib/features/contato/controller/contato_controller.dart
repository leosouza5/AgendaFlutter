import 'package:agenda/features/contato/model/contato_model.dart';
import 'package:agenda/services/database_service.dart';
import 'package:flutter/material.dart';

class ContatoController extends ChangeNotifier {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numeroController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<ContatoModel> listaDeContatos = [];

  void criaContato(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        final db = DatabaseService.instance;

        db.novoContato(
          contato: ContatoModel(nome: nomeController.text, numero: numeroController.text, email: emailController.text),
        );
        FocusScope.of(context).unfocus();

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Contato criado com sucesso !")));
        await recuperaContato();
        Navigator.pop(context);
      } catch (e) {
        print("ERROOOOOOOOOOOOOOO");
        print(e.toString());
        rethrow;
      }
    }
  }

  void deletaContato(BuildContext context, ContatoModel contato) async {
    final db = DatabaseService.instance;

    await db.deleteContato(contato.id!);

    await recuperaContato();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Contato criado com sucesso !")));
    Navigator.pop(context);
  }

  void editaContato(BuildContext context, ContatoModel contato) async {
    if (formKey.currentState!.validate()) {
      final db = DatabaseService.instance;
      contato.nome = nomeController.text;
      contato.email = emailController.text;
      contato.numero = numeroController.text;
      await db.updateContato(contato);

      FocusScope.of(context).unfocus();
      await recuperaContato();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Contato atualizado com sucesso !")));
      Navigator.pop(context);
    }
  }

  Future<void> recuperaContato() async {
    try {
      final db = DatabaseService.instance;
      listaDeContatos = await db.recuperaContatos();
      notifyListeners();
    } catch (e) {}
  }

  bool validaNumeroTelefone(String? telefone) {
    if (telefone == null) return false;

    final regex = RegExp(r'^\(\d{2}\) 9\d{4}-\d{4}$');

    return regex.hasMatch(telefone);
  }

  void preencheCampos(ContatoModel contato) {
    numeroController.text = contato.numero;
    emailController.text = contato.email;
    nomeController.text = contato.nome;
  }

  void reset() {
    nomeController.clear();
    emailController.clear();
    numeroController.clear();
  }
}
