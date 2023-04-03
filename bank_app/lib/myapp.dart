import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/AddExtratoPage.dart';
import 'screens/HistoricoPage.dart';
import 'state_extratoBancario.dart';

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
        home: MyPages(),
      ),
    );
  }
}

class MyPages extends StatefulWidget {
  @override
  State<MyPages> createState() => _MyPagesState();
}

class _MyPagesState extends State<MyPages> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
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
