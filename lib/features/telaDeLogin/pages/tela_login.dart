import 'package:agenda/features/contato/components/input.dart';
import 'package:agenda/features/home/pages/home_screen.dart';
import 'package:agenda/features/telaDeLogin/controller/auth_controller.dart';
import 'package:agenda/features/telaDeLogin/pages/tela_cadastro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  @override
  void initState() {
    verificarLogin();
    super.initState();
  }

  Future<void> verificarLogin() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();   === TROCADO POR SECURE STORAGE
    // final String? token = prefs.getString('token');
    final storage = FlutterSecureStorage();
    final String? token = await storage.read(key: 'token');

    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<AuthController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF213435),
      appBar: AppBar(
        backgroundColor: const Color(0xFF213435),
        centerTitle: true,
        title: const Text(
          "Agenda",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Card(
              elevation: 6,
              child: Container(
                decoration: BoxDecoration(color: const Color(0xFF648a64), borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Bem-vindo a Agenda",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 28),
                      ),
                      Form(
                        key: controller.formLogin,
                        child: Column(
                          children: [
                            Input(
                              controller: controller.controllerUsuarioLogin,
                              label: Text("Usuario"),
                              validator: (value) {
                                if (value == '') {
                                  return "Informe um nome válido";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            Input(
                              controller: controller.controllerSenhaLogin,
                              label: Text("Senha"),
                              senha: true,
                              validator: (value) {
                                if (value == '') {
                                  return "Informe um senha válido";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.logar(context);
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                                fixedSize: const Size(300, 50),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                elevation: 4,
                              ),
                              child: const Text(
                                "Entrar",
                              ),
                            )),
                      ),
                      Row(
                        children: [
                          const Text(
                            "Não tem conta ?",
                            style: TextStyle(color: Colors.white70),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TelaCadastro(),
                                  ));
                            },
                            child: Text(
                              "Cadastrar",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
