import 'package:flutter/material.dart';

import '../state_extratoBancario.dart';

class CardTransacao extends StatelessWidget {
  const CardTransacao({
    super.key,
    required this.historico,
    required this.textStyle,
    required this.index,
  });

  final List<Extrato> historico;
  final TextStyle textStyle;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(12)),
      title: Text(
        "${historico[index].nome}",
        style: textStyle.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "${historico[index].categoria}",
        style: textStyle.copyWith(fontSize: 16),
      ),
      trailing: Text(
        "R\$ ${historico[index].entrada ? historico[index].valor.toStringAsFixed(2) : -historico[index].valor}",
        style: historico[index].entrada
            ? textStyle.copyWith(
                color: Colors.green[700], fontWeight: FontWeight.bold)
            : textStyle.copyWith(
                color: Colors.red[900], fontWeight: FontWeight.bold),
      ),
    );
  }
}
