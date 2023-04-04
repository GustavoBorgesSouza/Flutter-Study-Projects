import 'package:favoriter/screens/AddExtratoPage.dart';
import 'package:flutter/material.dart';

import '../screens/HistoricoPage.dart';
import '../state_extratoBancario.dart';
import 'FormsCadastro.dart';

class BotaoEnvioForm extends StatelessWidget {
  BotaoEnvioForm({
    super.key,
    required this.index,
    GlobalKey<FormState>? formKey,
    opcaoTransacao? opcao,
    this.extratoCriado,
    this.tituloController,
    this.categoriaController,
    this.valorController,
    this.appState,
  })  : _formKey = formKey,
        _opcao = opcao;

  GlobalKey<FormState>? _formKey;
  opcaoTransacao? _opcao;
  Extrato? extratoCriado;
  TextEditingController? tituloController;
  TextEditingController? categoriaController;
  TextEditingController? valorController;
  MyAppState? appState;
  final bool index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black38))),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 10),
      child: ElevatedButton(
        onPressed: () {
          if (index) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddExtractPage(),
              ),
            );
          } else {
            if (_formKey!.currentState!.validate()) {
              _opcao == opcaoTransacao.entrada
                  ? extratoCriado!.entrada = true
                  : extratoCriado!.entrada = false;
              extratoCriado!.nome = tituloController!.text;
              extratoCriado!.categoria = categoriaController!.text;
              extratoCriado!.valor = double.parse(valorController!.text);

              print(""""
          nome ${extratoCriado!.nome}
          categoria ${extratoCriado!.categoria}
          valor ${extratoCriado!.valor}
          entrada ${extratoCriado!.entrada}
    """);
              appState!.adicionarExtrato(extratoCriado!);
              appState!.calcularExtrato();

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HistoryPage(),
                ),
              );
            }
          }
        },
        child: Text(index ? "Adicionar" : "Salvar"),
      ),
    );
  }
}
