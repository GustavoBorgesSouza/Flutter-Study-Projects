import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Bank App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class Extrato {
  String nome;
  String categoria;
  double valor;

  Extrato(this.nome, this.categoria, this.valor);
}

class MyAppState extends ChangeNotifier {
  double saldo = 0.0;

  var historico = <Extrato>[
    Extrato("oi", "aaaa", 10.5),
    Extrato("Oi", "aaaa", -2.5),
    Extrato("Oi", "aaaa", -2.5),
    Extrato("Oi", "aaaa", -2.5),
    Extrato("Oi", "aaaa", -3.5),
    Extrato("Oi", "aaaa", -3.5),
    Extrato("Oi", "aaaa", -3.5),
    Extrato("Oi", "aaaa", -3.5),
  ];

  GlobalKey? chaveListaHistorico;

  void adicionarExtrato(Extrato extrato) {
    historico.add(extrato);

    notifyListeners();
  }

  void calcularExtrato() {
    for (var i = 0; i < historico.length; i++) {
      saldo = saldo + historico[i].valor;
    }

    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HistoryPage();
        break;
      case 1:
        page = AddExtractPage();
        break;
      default:
        throw UnimplementedError(
            "no widget for selected index: $selectedIndex");
    }

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
      ),
      home: Builder(
        builder: (context) => Scaffold(
          body: page,
        ),
      ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var saldo = appState.saldo;
    var historico = appState.historico;

    var colorScheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

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
                    FooterBotao(),
                  ],
                ),
              )),
    );
  }
}

class FooterBotao extends StatelessWidget {
  const FooterBotao({
    super.key,
  });

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
        child: Text("Adicionar"),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddExtractPage(),
            ),
          );
        },
      ),
    );
  }
}

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
        "R\$ ${historico[index].valor}",
        style: textStyle.copyWith(),
      ),
    );
  }
}

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
            "R\$ $saldo",
            style:
                textStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ],
      ),
    );
  }
}

class AddExtractPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var colorScheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

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

class FormsCadastro extends StatelessWidget {
  FormsCadastro({
    super.key,
  });

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Form(
              child: Column(
                children: [
                  InputExtrato(myController: myController),
                  // Row(
                  //   children: <Widget>[
                  //     RadioListTile(
                  //       title: const Text('Entrada'),
                  //       value: "Entrada",
                  //       groupValue: "entreada",
                  //       onChanged: (value) => print(value),
                  //     ),
                  //     RadioListTile(
                  //       value: "Saída",
                  //       groupValue: 1,
                  //       onChanged: (value) => print(value),
                  //     ),
                  //   ],
                  // ),
                  Text("aaaaaaaaa"),
                  Icon(Icons.favorite),
                ],
              ),
            ),
          ),
        ),
        FooterBotao(),
      ],
    );
  }
}

class InputExtrato extends StatelessWidget {
  const InputExtrato({
    super.key,
    required this.myController,
    // required this.label,
  });

  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        // hintText: label,
      ),
    );
  }
}
