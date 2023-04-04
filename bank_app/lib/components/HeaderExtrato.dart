import 'package:flutter/material.dart';

class HeaderExtrato extends StatelessWidget {
  const HeaderExtrato({
    super.key,
    required this.textStyle,
    required this.saldo,
  });

  final TextStyle textStyle;
  final double saldo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.black38))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Montante",
                style: textStyle.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 22),
              ),
              Text(
                "Saldo em conta",
                style: textStyle,
              ),
            ],
          ),
          Text(
            "R\$ ${saldo.toStringAsFixed(2)}",
            style:
                textStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ],
      ),
    );
  }
}
