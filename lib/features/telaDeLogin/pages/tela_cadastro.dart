import 'package:agenda/features/contato/components/input.dart';
import 'package:agenda/features/telaDeLogin/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TelaCadastro extends StatelessWidget {
  const TelaCadastro({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF213435),
      appBar: AppBar(
        backgroundColor: const Color(0xFF213435),
        centerTitle: true,
        title: const Text(
          "Cadastro de usuario",
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
                  child: Form(
                    key: controller.formCadastro,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Input(
                              validator: (value) {
                                if (value == '') {
                                  return "Informe um nome válido";
                                } else {
                                  return null;
                                }
                              },
                              controller: controller.controllerUsuarioCadastro,
                              label: Text("Usuario"),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            Input(
                              validator: (value) {
                                if (value == '') {
                                  return "Informe uma senha válido";
                                } else {
                                  return null;
                                }
                              },
                              controller: controller.controllerSenhaCadastro,
                              label: Text("Senha"),
                              senha: true,
                            ),
                            Input(
                              validator: (value) {
                                if (value != controller.controllerSenhaCadastro.text) {
                                  return "As senhas devem ser iguais";
                                } else {
                                  return null;
                                }
                              },
                              controller: controller.controllerConfirmaSenhaCadastro,
                              label: Text("Confirme a senha"),
                              senha: true,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.cadastrar(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                                  fixedSize: const Size(300, 50),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                  elevation: 4,
                                ),
                                child: const Text(
                                  "Cadastrar",
                                ),
                              )),
                        ),
                      ],
                    ),
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
