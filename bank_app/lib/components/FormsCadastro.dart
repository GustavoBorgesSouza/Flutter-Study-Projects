import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state_extratoBancario.dart';

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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Extrato extratoCriado = Extrato.empty();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Expanded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
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
                  BotaoEnvioForm(
                    formKey: _formKey,
                    opcao: _opcao,
                    extratoCriado: extratoCriado,
                    tituloController: tituloController,
                    categoriaController: categoriaController,
                    valorController: valorController,
                    appState: appState,
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

class BotaoEnvioForm extends StatelessWidget {
  const BotaoEnvioForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required opcaoTransacao? opcao,
    required this.extratoCriado,
    required this.tituloController,
    required this.categoriaController,
    required this.valorController,
    required this.appState,
  })  : _formKey = formKey,
        _opcao = opcao;

  final GlobalKey<FormState> _formKey;
  final opcaoTransacao? _opcao;
  final Extrato extratoCriado;
  final TextEditingController tituloController;
  final TextEditingController categoriaController;
  final TextEditingController valorController;
  final MyAppState appState;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _opcao == opcaoTransacao.entrada
                ? extratoCriado.entrada = true
                : extratoCriado.entrada = false;
            extratoCriado.nome = tituloController.text;
            extratoCriado.categoria = categoriaController.text;
            extratoCriado.valor = double.parse(valorController.text);

            print(""""
        nome ${extratoCriado.nome}
        categoria ${extratoCriado.categoria}
        valor ${extratoCriado.valor}
        entrada ${extratoCriado.entrada}
""");
            appState.adicionarExtrato(extratoCriado);
            appState.calcularExtrato();
          }
        },
        child: Text("Opa"));
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
      validator: (value) {
        switch (label) {
          case "Título":
          case "Categoria":
            if (value == null || value.isEmpty) {
              return "Por favor, digite um texto válido";
            }
            break;
          case "Valor":
            if (double.parse(value!) <= 0 ||
                value.isEmpty ||
                double.parse(value).isNaN ||
                value == null) {
              return "Por favor, digite um número válido e maior que zero";
            }
            break;
          default:
            return "Please what?";
        }

        return null;
      },
      controller: myController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: label,
      ),
    );
  }
}
