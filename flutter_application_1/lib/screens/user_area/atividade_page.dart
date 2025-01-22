import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../main.dart';
import '../../models/atividade.dart';
import '../../models/user.dart';

class AtividadePage extends StatefulWidget {
  const AtividadePage({Key? key}) : super(key: key);

  @override
  AtividadePageState createState() => AtividadePageState();
}

class AtividadePageState extends State<AtividadePage> {
  late User? _user;

  @override
  void initState() {
    super.initState();
    if (MyApp.loggedInUser != null) {
      _user = MyApp.loggedInUser;
      _user!.atvHistorico.sort((a, b) => a.dataEntrega.compareTo(b.dataEntrega));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (MyApp.loggedInUser == null) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, '/login');
      });
      return const SizedBox.shrink();
    }

    return Theme(
      data: Theme.of(context),
      child: Scaffold(
        body: Center(
          child: ListView.builder(
            itemCount: _user!.atvHistorico.length,
            itemBuilder: (context, index) {
              final delivery = _user!.atvHistorico[index];
              String formattedDate = DateFormat('dd-MM-yyyy').format(delivery.dataEntrega);

              return Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  title: Text(
                    delivery.nomeProduto,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0, // Adjust the font size as needed
                    ),
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      text: 'Entregue em $formattedDate para ',
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: delivery.locDestino,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: '\nPreço Pago: ',
                        ),
                        TextSpan(
                          text: '${delivery.custo.toStringAsFixed(2)}€',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () => _showDeliveryDetails(context, delivery),
                ),

              );
            },
          ),
        ),
      ),
    );
  }

  void _showDeliveryDetails(BuildContext context, Atividade delivery) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: AlertDialog(
            title: Text(delivery.nomeProduto),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Data de Entrega: ${DateFormat('dd-MM-yyyy').format(delivery.dataEntrega)}'),
                Text('Peso do Produto: ${delivery.pesoProduto} kg'),
                Text('Dimensões do Produto: ${delivery.profundidadeProduto} x ${delivery.larguraProduto} x ${delivery.alturaProduto} cm'),
                Text('Local do Remetente: ${delivery.locRemetente}'),
                Text('Local de Destino: ${delivery.locDestino}'),
                Text('Preço Pago: ${delivery.custo.toStringAsFixed(2)}€'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Fechar'),
              ),
            ],
          ),
        );
      },
    );
  }
}
