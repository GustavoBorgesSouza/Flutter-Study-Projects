import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class Assinatura extends StatefulWidget {
  final SignatureController _controller;

  Assinatura(this._controller);

  @override
  _AssinaturaState createState() => _AssinaturaState();
}

class _AssinaturaState extends State<Assinatura> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Campo de assinatura'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Assine aqui seu documento: ',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            // ignore: prefer_const_constructors
            SizedBox(
              height: 50,
            ),
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Signature(
                controller: widget._controller,
                height: 300,
                backgroundColor: Colors.transparent,
              ),
            ),
            Row(
              children: [
                TextButton(
                    onPressed: () async {
                      widget._controller.clear();
                    },
                    child: const Text('Limpar')),
                TextButton(
                    onPressed: () async {
                      var data = await widget._controller.toPngBytes();

                      Navigator.pop(context, data);
                    },
                    child: const Text('Concluir')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
