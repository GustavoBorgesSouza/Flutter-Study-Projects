import 'package:flutter/cupertino.dart';

class Extrato {
  String nome;
  String categoria;
  double valor;
  bool entrada;

  Extrato(this.nome, this.categoria, this.valor, this.entrada);
}

class MyAppState extends ChangeNotifier {
  double saldo = 0.0;

  var historico = <Extrato>[
    Extrato("oi", "aaaa", 10.5, true),
    Extrato("Oi", "aaaa", 3.5, false),
    Extrato("Oi", "aaaa", 2.5, true),
    Extrato("Oi", "aaaa", 2.5, true),
    Extrato("Oi", "aaaa", 3.5, false),
    Extrato("Oi", "aaaa", 2.5, true),
    Extrato("Oi", "aaaa", 3.5, false),
    Extrato("Oi", "aaaa", 3.5, false),
  ];

  GlobalKey? chaveListaHistorico;

  void adicionarExtrato(Extrato extrato) {
    historico.add(extrato);

    notifyListeners();
  }

  void calcularExtrato() {
    for (var i = 0; i < historico.length; i++) {
      historico[i].entrada
          ? saldo = saldo + historico[i].valor
          : saldo = saldo - historico[i].valor;
    }

    notifyListeners();
  }
}
