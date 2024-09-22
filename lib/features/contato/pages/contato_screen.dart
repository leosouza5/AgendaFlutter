import 'package:agenda/features/contato/components/input.dart';
import 'package:agenda/features/contato/controller/contato_controller.dart';
import 'package:agenda/features/contato/model/contato_model.dart';
import 'package:agenda/features/global/formatacao/numero_telefone_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContatoScreen extends StatefulWidget {
  final bool edicao;
  final ContatoModel? model;
  const ContatoScreen({super.key, this.edicao = false, this.model});

  @override
  State<ContatoScreen> createState() => _ContatoScreenState();
}

class _ContatoScreenState extends State<ContatoScreen> {
  @override
  void initState() {
    context.read<ContatoController>().reset();
    if (widget.edicao) {
      context.read<ContatoController>().preencheCampos(widget.model!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ContatoController>();
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF213435),
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: Text(
          widget.edicao ? "Editar Contato" : "Novo Contato",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        backgroundColor: const Color(0xFF213435),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF648a64),
          ),
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Input(
                      controller: controller.nomeController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Digite um nome válido";
                        } else {
                          return null;
                        }
                      },
                      label: const Text("Nome"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Input(
                      controller: controller.emailController,
                      validator: (value) {
                        if (value == null || !value.contains("@")) {
                          return "Informe um Email válido";
                        } else {
                          return null;
                        }
                      },
                      label: const Text("Email"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Input(
                      inputFormatters: [TelefoneInputFormatter()],
                      controller: controller.numeroController,
                      validator: (value) {
                        if (!controller.validaNumeroTelefone(value)) {
                          return "Digite um numero no formato : (XX) 9XXXX-XXXX";
                        } else {
                          return null;
                        }
                      },
                      label: const Text("Numero"),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (widget.edicao)
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {
                            controller.deletaContato(context, widget.model!);
                          },
                          style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), backgroundColor: const Color(0xFFbe4c54)),
                          child: const Text("Deletar", style: TextStyle(color: Colors.white)),
                        )),
                      if (widget.edicao) const SizedBox(width: 20),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          widget.edicao ? controller.editaContato(context, widget.model!) : controller.criaContato(context);
                        },
                        style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        child: const Text("Salvar"),
                      )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
