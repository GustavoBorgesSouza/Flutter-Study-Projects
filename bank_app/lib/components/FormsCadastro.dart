import 'package:flutter/material.dart';

enum opcaoTransacao { entrada, saida }

class FormsCadastro extends StatefulWidget {
  FormsCadastro({
    super.key,
  });

  @override
  State<FormsCadastro> createState() => _FormsCadastroState();
}

class _FormsCadastroState extends State<FormsCadastro> {
  opcaoTransacao? _opcao = opcaoTransacao.entrada;

  final tituloController = TextEditingController();

  final categoriaController = TextEditingController();

  final valorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
              child: Column(
                children: [
                  InputExtrato(myController: tituloController, label: "Título"),
                  SizedBox(height: 15),
                  InputExtrato(
                      myController: categoriaController, label: "Categoria"),
                  SizedBox(height: 15),
                  InputExtrato(myController: valorController, label: "Valor"),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: RadioListTile<opcaoTransacao>(
                          title: const Text('Entrada'),
                          value: opcaoTransacao.entrada,
                          groupValue: _opcao,
                          onChanged: (opcaoTransacao? value) {
                            setState(() {
                              _opcao = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: RadioListTile<opcaoTransacao>(
                          title: const Text("Saída"),
                          value: opcaoTransacao.saida,
                          groupValue: _opcao,
                          onChanged: (opcaoTransacao? value) {
                            setState(() {
                              _opcao = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InputExtrato extends StatelessWidget {
  const InputExtrato({
    super.key,
    required this.myController,
    required this.label,
  });

  final TextEditingController myController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: label,
      ),
    );
  }
}
