import 'package:favoriter/components/FootterBotao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/ExtratoScroll.dart';
import '../components/FooterBotao.dart';
import '../components/HeaderExtrato.dart';
import '../state_extratoBancario.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var saldo = appState.saldo;
    var historico = appState.historico;

    final textStyle = TextStyle(fontSize: 18);

    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("Meu Dinheiro"),
            centerTitle: true,
            backgroundColor: Colors.grey[350],
            foregroundColor: Colors.black,
          ),
          body: Column(
            children: [
              HeaderExtrato(textStyle: textStyle, saldo: saldo),
              ExtratoScroll(historico: historico, textStyle: textStyle),
              BotaoEnvioForm(
                index: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
