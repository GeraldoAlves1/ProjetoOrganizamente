import 'package:flutter/material.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  ElevatedButton botoesPrincipais(
      IconData icon, String text, void Function() onPress) {
    return ElevatedButton(
      onPressed: onPress,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: const Color.fromARGB(1000, 247, 148, 30),
              size: 40,
            ),
            const SizedBox(
              width: 50,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 25,
                fontFamily: 'Kanit',
                color: Color.fromARGB(1000, 247, 148, 30),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: 0.5, // Isso cobre metade da tela.
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/t22.png'), // Substitua com o caminho da sua imagem.
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: SafeArea(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Image(
                      image: AssetImage('assets/oglogo.png'),
                      width: 170,
                      height: 120,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        botoesPrincipais(
                            Icons.water_drop_outlined, "Beber água", () {
                          Navigator.of(context).pushNamed('/TelaBeberAgua');
                        }),
                        const SizedBox(height: 40),
                        botoesPrincipais(Icons.delete_outline, "Coleta de lixo",
                            () {
                          Navigator.of(context).pushNamed('/TelaColeta');
                        }),
                        const SizedBox(height: 40),
                        botoesPrincipais(Icons.menu_book_outlined, "Cultura",
                            () {
                          Navigator.of(context).pushNamed('/TelaBeberAgua');
                        }),
                        const SizedBox(height: 40),
                        botoesPrincipais(
                            Icons.watch_later_outlined, "Gerenciar tempo", () {
                          Navigator.of(context).pushNamed('/TelaBeberAgua');
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
