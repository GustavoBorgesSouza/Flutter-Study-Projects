import 'package:favoriter/screens/HistoricoPage.dart';
import 'package:flutter/material.dart';

import '../screens/AddExtratoPage.dart';

class FooterBotao extends StatelessWidget {
  const FooterBotao({super.key, required this.index});

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
        child: Text(index ? "Adicionar" : "Salvar"),
        onPressed: () {
          if (index) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddExtractPage(),
              ),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HistoryPage(),
              ),
            );
          }
        },
      ),
    );
  }
}
