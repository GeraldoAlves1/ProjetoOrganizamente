import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TelaColeta extends StatefulWidget {
  const TelaColeta({super.key});

  @override
  State<TelaColeta> createState() => _TelaColetaState();
}

class _TelaColetaState extends State<TelaColeta> {
  final Uri _diaColeta =
      Uri.parse('https://www.juazeirodonorte.ce.gov.br/informa.php?id=27357');
  final Uri _separar =
      Uri.parse('https://www.ecycle.com.br/separacao-de-lixo/');
  final Uri _reciclagem =
      Uri.parse('https://www.juazeirodonorte.ce.gov.br/informa.php?id=26169');
  Future<void> diasDaColeta() async {
    if (!await launchUrl(_diaColeta)) {
      throw Exception('Could not launch $_diaColeta');
    }
  }

  Future<void> comoSeparar() async {
    if (!await launchUrl(_separar)) {
      throw Exception('Could not launch $_separar');
    }
  }

  Future<void> pontosReciclagem() async {
    if (!await launchUrl(_reciclagem)) {
      throw Exception('Could not launch $_reciclagem');
    }
  }

  ElevatedButton botoesColeta(
      Color corFundo, Color corIcone, String text, void Function() onPress) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: corFundo,
      ),
      onPressed: onPress,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            Icon(
              Icons.delete,
              color: corIcone,
              size: 30,
            ),
            const SizedBox(
              width: 30,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Kanit',
                color: Colors.black,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Voltar",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromARGB(1000, 247, 148, 30),
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: const Text(
                        "Coleta do lixo",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Kanit',
                          color: Color.fromARGB(1000, 247, 148, 30),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Image(
                      image: AssetImage('assets/latas.png'),
                      width: 300,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    botoesColeta(
                      Colors.green[100]!,
                      Colors.green[900]!,
                      "Como descartar seu lixo?",
                      () {
                        comoSeparar();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    botoesColeta(
                      Colors.blue[100]!,
                      Colors.blue[900]!,
                      "Quais são os dias de coleta?",
                      () {
                        diasDaColeta();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    botoesColeta(
                      Colors.red[100]!,
                      Colors.red[900]!,
                      "Pontos de reciclagem",
                      () {
                        pontosReciclagem();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    botoesColeta(
                      Colors.yellow[100]!,
                      Colors.yellow[900]!,
                      "Lembre-me",
                      () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
