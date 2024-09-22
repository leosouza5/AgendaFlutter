import 'package:agenda/features/contato/model/contato_model.dart';
import 'package:agenda/features/home/model/agenda_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContatoController extends ChangeNotifier {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numeroController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void criaContato(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<AgendaModel>().contatos.add(
            ContatoModel(nome: nomeController.text, numero: numeroController.text, email: emailController.text),
          );
      FocusScope.of(context).unfocus();
      context.read<AgendaModel>().notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Contato criado com sucesso !")));
      Navigator.pop(context);
    }
  }

  void deletaContato(BuildContext context, ContatoModel contato) {
    context.read<AgendaModel>().contatos.remove(contato);
    context.read<AgendaModel>().notifyListeners();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Contato criado com sucesso !")));
    Navigator.pop(context);
  }

  void editaContato(BuildContext context, ContatoModel contato) {
    if (formKey.currentState!.validate()) {
      contato.nome = nomeController.text;
      contato.email = emailController.text;
      contato.numero = numeroController.text;
      FocusScope.of(context).unfocus();
      context.read<AgendaModel>().notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Contato atualizado com sucesso !")));
      Navigator.pop(context);
    }
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
