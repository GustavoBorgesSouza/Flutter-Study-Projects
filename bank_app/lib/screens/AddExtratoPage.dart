import 'package:flutter/material.dart';
import '../components/FormsCadastro.dart';

class AddExtractPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("Adicionar"),
            centerTitle: true,
            backgroundColor: Colors.grey[350],
            foregroundColor: Colors.black,
          ),
          body: FormsCadastro(),
        ),
      ),
    );
  }
}
