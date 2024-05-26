import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TelaBeberAgua extends StatefulWidget {
  const TelaBeberAgua({super.key});

  @override
  State<TelaBeberAgua> createState() => _TelaBeberAguaState();
}

class _TelaBeberAguaState extends State<TelaBeberAgua>
    with TickerProviderStateMixin {
  final TextEditingController _txtController = TextEditingController();
  late final AnimationController _controller;
  late final AnimationController _controller2;
  double valorCopo = 0;
  double metaIndividual = 0;
  double percentage = 0;

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void _calcular() {
    setState(() {
      if (_txtController.text.isNotEmpty) {
        metaIndividual = double.parse(_txtController.text) * 35;
      }
    });
  }

  void adicionar() {
    setState(() {
      if (metaIndividual == 0) {
        valorCopo = 0;
      } else {
        valorCopo += 150;
        _controller.forward();
      }

      if (valorCopo > metaIndividual) {
        showToast("Parabéns! Você concluiu seu objetivo diário.");
        celebracao(context);
        _controller2.forward().whenComplete(
              () => Navigator.of(context).pop(),
            );
      }
    });
  }

  void remover() {
    setState(() {
      if (valorCopo > 0) {
        valorCopo -= 150;
      }
    });
  }

  void celebracao(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(0),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Lottie.asset('lottie/confetti.json',
                controller: _controller2,
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                repeat: true), // Substitua pelo caminho da sua animação Lottie
          ),
        );
      },
    );
  }

  void aumentarBarra() {
    setState(() {
      if (percentage < metaIndividual) {
        percentage += (1 / metaIndividual) * 150;
        if (percentage >= 1) {
          percentage = 1;
        }
      }
    });
  }

  void diminuirBarra() {
    setState(() {
      if (valorCopo >= metaIndividual) {
        percentage = 1;
      } else {
        percentage -= (1 / metaIndividual) * 150;
        if (percentage <= 0) {
          percentage = 0;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.duration = const Duration(seconds: 4);
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addStatusListener((status) {
        if (status == AnimationStatus.forward && _controller.value > 1) {
          _controller.reverse();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _txtController.dispose();
    _controller2.dispose();
    super.dispose();
  }

  void _avancaAnimacao() {
    final double pedaco = metaIndividual / valorCopo;
    final double novoProgresso = (_controller.value + pedaco).clamp(0.0, 1.0);
    _controller.animateTo(novoProgresso);
  }

  void _botaoAjuda() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Column(
            children: [
              AlertDialog(
                title: Center(
                    child: Text(
                  "Água",
                  style: TextStyle(
                    fontFamily: 'Kanit',
                  ),
                )),
                content: Column(
                  children: [
                    Text(
                      "Essa é uma média de acordo com o peso de cada pessoa",
                      style: TextStyle(
                        fontFamily: 'Kanit',
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Alguns fatores podem influênciar no consumo diário como: ",
                      style: TextStyle(
                        fontFamily: 'Kanit',
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "• Clima da cidade",
                          style: TextStyle(
                            fontFamily: 'Kanit',
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "• Algumas doenças",
                          style: TextStyle(
                            fontFamily: 'Kanit',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "• Atividade física",
                          style: TextStyle(
                            fontFamily: 'Kanit',
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          " • Idade",
                          style: TextStyle(
                            fontFamily: 'Kanit',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Voltar",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Kanit',
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _botaoAjuda();
                      },
                      child: const Text(
                        "Ajuda",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Kanit',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 90,
                        child: TextField(
                          controller: _txtController,
                          decoration: const InputDecoration(
                            label: Text(
                              "Peso (kg):",
                              style: TextStyle(
                                fontFamily: 'Kanit',
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: Color.fromARGB(1000, 247, 148, 30),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(1000, 247, 148, 30),
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () {
                            _calcular();
                          },
                          child: const Text(
                            "Calcular",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Kanit',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Column(
                    children: [
                      CircularPercentIndicator(
                        circularStrokeCap: CircularStrokeCap.round,
                        radius: 150,
                        animation: true,
                        percent: percentage,
                        lineWidth: 20,
                        animateFromLastPercent: true,
                        center: Text(
                            "${valorCopo.toStringAsFixed(0)} ml / ${metaIndividual.toStringAsFixed(0)} ml "),
                        progressColor: const Color.fromARGB(1000, 247, 148, 30),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            Text(
                              "${valorCopo.toStringAsFixed(0)} ml / ${metaIndividual.toStringAsFixed(0)} ml",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: 'Kanit',
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(
                                      side: BorderSide.none,
                                    ),
                                    minimumSize: const Size(70, 70),
                                    backgroundColor: const Color.fromARGB(
                                        1000, 247, 148, 30),
                                  ),
                                  onPressed: () {
                                    remover();
                                    diminuirBarra();
                                  },
                                  child: const Text(
                                    "- 150ml",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Kanit',
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(
                                        side: BorderSide.none,
                                      ),
                                      minimumSize: const Size(70, 70),
                                      backgroundColor: const Color.fromARGB(
                                          1000, 247, 148, 30)),
                                  onPressed: () {
                                    adicionar();
                                    _avancaAnimacao();
                                    aumentarBarra();
                                  },
                                  child: const Text(
                                    "+ 150ml",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Kanit',
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
