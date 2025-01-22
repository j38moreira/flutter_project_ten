import 'package:flutter/material.dart';
import '../../main.dart';
import '../../models/atividade.dart';
import '../../models/user.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  MapaPageState createState() => MapaPageState();
}

class MapaPageState extends State<MapaPage> {
  late User? _user;
  late TextEditingController destinatarioController;
  late TextEditingController remetenteController;
  late TextEditingController nomeProdutoController;
  late TextEditingController comprimentoController;
  late TextEditingController larguraController;
  late TextEditingController alturaController;
  late TextEditingController pesoController;

  @override
  void initState() {
    super.initState();
    if (MyApp.loggedInUser != null) {
      _user = MyApp.loggedInUser;
    }
    destinatarioController = TextEditingController();
    remetenteController = TextEditingController();
    nomeProdutoController = TextEditingController();
    comprimentoController = TextEditingController();
    larguraController = TextEditingController();
    alturaController = TextEditingController();
    pesoController = TextEditingController();
  }

  void _mostrarDetalhesEncomenda(String remetente, String destinatario, String nomeProduto, double comprimento,
      double largura, double altura, double peso, {String? veiculo, double? custoTotal}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Detalhes da Encomenda'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Remetente: $remetente'),
              Text('Destinatário: $destinatario'),
              Text('Nome do Produto: $nomeProduto'),
              Text('Tamanho: $comprimento x $largura x ${altura}cm'),
              Text('Peso: $peso kg'),
              if (veiculo != null) Text('Veículo Escolhido: $veiculo'),
              if (custoTotal != null) Text('Custo Total: ${custoTotal.toStringAsFixed(2)}€'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Voltar'),
            ),
            ElevatedButton(
              onPressed: () {
                double custoTotalValue = custoTotal ?? 0.0;

                Atividade novaEncomenda = Atividade(
                  nomeProduto,
                  DateTime.now(),
                  peso,
                  comprimento,
                  largura,
                  altura,
                  remetente,
                  destinatario,
                  custo: custoTotalValue,
                );
                _user?.atvHistorico.add(novaEncomenda);
                Navigator.pop(context);
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarEscolhaVeiculo(double comprimento, double largura, double altura, double peso) {
    List<Map<String, dynamic>> opcoesVeiculos = [];

    if (comprimento > 180 || largura > 100 || altura > 60) {
      opcoesVeiculos.add({'nome': 'Carrinha', 'preco': '+5€'});
    } else {
      double custoCarro = 2.0;

      opcoesVeiculos.add({'nome': 'Carro', 'preco': '+€${custoCarro.toStringAsFixed(2)}'});
      opcoesVeiculos.add({'nome': 'Carro Eco', 'preco': 'Sem Taxas Adicionais'});
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Escolha o Veículo'),
          children: opcoesVeiculos
              .map((opcao) => SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, opcao);
                    },
                    child: Row(
                      children: [
                        Text(opcao['nome']),
                        const Spacer(),
                        Text(opcao['preco']),
                      ],
                    ),
                  ))
              .toList(),
        );
      },
    ).then((selectedOpcao) {
      if (selectedOpcao != null) {
        double custoVeiculo = 0.0;

        if (selectedOpcao['nome'] == 'Carrinha') {
          custoVeiculo = 5.0;
        } else if (selectedOpcao['nome'] == 'Carro') {
          custoVeiculo = 2.0;
        }

        double custoTotal = calcularCustoTotal(comprimento, largura, altura, peso, custoVeiculo);

        _mostrarDetalhesEncomenda(
          remetenteController.text,
          destinatarioController.text,
          nomeProdutoController.text,
          comprimento,
          largura,
          altura,
          peso,
          veiculo: selectedOpcao['nome'],
          custoTotal: custoTotal,
        );
      }
    });
  }

  double calcularCustoTotal(double comprimento, double largura, double altura, double peso, double custoVeiculo) {
    double taxaPorVolume = 0.001;
    double volumeProduto = comprimento * largura * altura;
    double taxaProduto = volumeProduto * taxaPorVolume;

    return taxaProduto + custoVeiculo;
  }

  void _mostrarFormularioEncomenda() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nomeProdutoController,
                  decoration: const InputDecoration(labelText: 'Nome do Produto'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: comprimentoController,
                  decoration: const InputDecoration(
                    labelText: 'Comprimento (cm)',
                    labelStyle: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: larguraController,
                  decoration: const InputDecoration(
                    labelText: 'Largura (cm)',
                    labelStyle: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: alturaController,
                  decoration: const InputDecoration(
                    labelText: 'Altura (cm)',
                    labelStyle: TextStyle(fontSize: 12),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: pesoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Peso (kg)'),
                ),
              ],
            ),
          ),
          contentPadding: const EdgeInsets.all(16.0),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (remetenteController.text.isNotEmpty &&
                    destinatarioController.text.isNotEmpty &&
                    nomeProdutoController.text.isNotEmpty &&
                    comprimentoController.text.isNotEmpty &&
                    larguraController.text.isNotEmpty &&
                    alturaController.text.isNotEmpty &&
                    pesoController.text.isNotEmpty) {

                  double comprimentoValue = double.tryParse(comprimentoController.text) ?? 0.0;
                  double larguraValue = double.tryParse(larguraController.text) ?? 0.0;
                  double alturaValue = double.tryParse(alturaController.text) ?? 0.0;
                  double pesoValue = double.tryParse(pesoController.text) ?? 0.0;

                  if (comprimentoValue >= 1.0 && larguraValue >= 1.0 && alturaValue >= 1.0 && pesoValue >= 0.1) {
                    Navigator.pop(context);
                    _mostrarEscolhaVeiculo(
                      comprimentoValue,
                      larguraValue,
                      alturaValue,
                      pesoValue,
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Erro'),
                          content: const Text('Valores incorretos.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Erro'),
                        content: const Text('Todos os campos são obrigatórios.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Escolher Veículo'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, '/login');
      });
      return const SizedBox.shrink();
    }

    return Theme(
      data: Theme.of(context),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/map.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: remetenteController,
                            decoration: const InputDecoration(labelText: 'Remetente'),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: destinatarioController,
                            decoration: const InputDecoration(labelText: 'Destinatario'),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              if (remetenteController.text.isNotEmpty &&
                                  destinatarioController.text.isNotEmpty) {
                                _mostrarFormularioEncomenda();
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Erro'),
                                      content: const Text('Todos os campos são obrigatórios.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: const Text('Pedir'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
