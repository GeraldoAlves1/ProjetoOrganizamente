import 'package:flutter/material.dart';
import 'package:teste_extensionista/screens/tela_beber_agua.dart';
import 'package:teste_extensionista/screens/tela_coleta.dart';
import 'package:teste_extensionista/screens/tela_principal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const TelaPrincipal(),
        '/TelaBeberAgua': (context) => const TelaBeberAgua(),
        '/TelaColeta': (context) => const TelaColeta(),
      },
    );
  }
}
