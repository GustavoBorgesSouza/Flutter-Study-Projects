import 'package:flutter/material.dart';

import '../state_extratoBancario.dart';
import 'CardTransacao.dart';

class ExtratoScroll extends StatelessWidget {
  const ExtratoScroll({
    super.key,
    required this.historico,
    required this.textStyle,
  });

  final List<Extrato> historico;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRect(
        child: ListView.separated(
            padding: EdgeInsets.all(20),
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
                  color: Colors.transparent,
                ),
            itemCount: historico.length,
            itemBuilder: (_, int index) {
              return CardTransacao(
                  historico: historico, textStyle: textStyle, index: index);
            }),
      ),
    );
  }
}
