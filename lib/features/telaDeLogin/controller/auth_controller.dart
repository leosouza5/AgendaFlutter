import 'package:agenda/features/home/pages/home_screen.dart';
import 'package:agenda/features/telaDeLogin/model/usuario_model.dart';
import 'package:agenda/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AuthController extends ChangeNotifier {
  GlobalKey<FormState> formCadastro = GlobalKey<FormState>();
  GlobalKey<FormState> formLogin = GlobalKey<FormState>();

  TextEditingController controllerUsuarioLogin = TextEditingController();
  TextEditingController controllerSenhaLogin = TextEditingController();

  TextEditingController controllerSenhaCadastro = TextEditingController();
  TextEditingController controllerConfirmaSenhaCadastro = TextEditingController();
  TextEditingController controllerUsuarioCadastro = TextEditingController();

  void cadastrar(BuildContext context) async {
    if (formCadastro.currentState!.validate()) {
      try {
        final db = DatabaseService.instance;

        await db.novoUsuario(
          contato: UsuarioModel(usuario: controllerUsuarioCadastro.text, senha: controllerSenhaCadastro.text),
        );
        FocusScope.of(context).unfocus();
        controllerUsuarioCadastro.clear();
        controllerSenhaCadastro.clear();
        controllerConfirmaSenhaCadastro.clear();

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Usuario criado com sucesso !")));
        Navigator.pop(context);
      } catch (e) {
        rethrow;
      }
    }
  }

  void logar(BuildContext context) async {
    if (formLogin.currentState!.validate()) {
      try {
        print('to no try');
        final db = DatabaseService.instance;

        FocusScope.of(context).unfocus();
        if (await db.verificarLogin(
          usuarioModel: UsuarioModel(usuario: controllerUsuarioLogin.text, senha: controllerSenhaLogin.text),
        )) {
          // final SharedPreferences prefs = await SharedPreferences.getInstance();
          // await prefs.setString('token', controllerUsuarioLogin.text);    ----- ALTERADO PARA SECURE STORAGE AGORA
          final Uuid uuid = Uuid();

          final storage = FlutterSecureStorage();
          await storage.write(key: 'token', value: uuid.v4());
          print(await storage.read(key: 'token'));

          controllerUsuarioLogin.clear();
          controllerSenhaLogin.clear();

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login feito com Sucesso !")));

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Usuario não encontrado !")));
        }
      } catch (e) {
        rethrow;
      }
    }
  }
}
