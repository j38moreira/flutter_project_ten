import 'package:flutter/material.dart';
import '../../main.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController numCCardController = TextEditingController();
  TextEditingController valCardController = TextEditingController();
  TextEditingController ccvController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nomeController.text = MyApp.loggedInUser?.nome ?? '';
    numCCardController.text = MyApp.loggedInUser?.numCCard.toString() ?? '';
    valCardController.text = MyApp.loggedInUser?.valCard.toString() ?? '';
    ccvController.text = MyApp.loggedInUser?.ccv.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    if (MyApp.loggedInUser == null) {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, '/login');
      });
      return const SizedBox.shrink();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  _showNameDialog(context);
                },
                child: const Text('Editar nome'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _showCreditCardDialog(context);
                },
                child: const Text('Editar cartão'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showNameDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Nome'),
          content: Column(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Novo Nome'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _saveName();
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  // Function to save the edited name
  void _saveName() {
    if (nomeController.text.isNotEmpty) {
      setState(() {
        MyApp.loggedInUser?.nome = nomeController.text;
      });
    } else {
      _showValidationError('O nome não pode estar vazio.');
    }
  }

  // Function to display a dialog for editing credit card details
  void _showCreditCardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Cartão de Crédito'),
          content: Column(
            children: [
              TextFormField(
                controller: numCCardController,
                decoration: const InputDecoration(labelText: 'Número do Cartão'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: valCardController,
                decoration: const InputDecoration(labelText: 'Validade do Cartão'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: ccvController,
                decoration: const InputDecoration(labelText: 'CCV'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _saveCreditCard();
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _saveCreditCard() {
    int newNumCCard = int.tryParse(numCCardController.text) ?? 0;
    int newValCard = int.tryParse(valCardController.text) ?? 0;
    int newCcv = int.tryParse(ccvController.text) ?? 0;

    if (_isValidCreditCardDetails(newNumCCard, newValCard, newCcv)) {
      setState(() {
        MyApp.loggedInUser?.numCCard = newNumCCard;
        MyApp.loggedInUser?.valCard = newValCard;
        MyApp.loggedInUser?.ccv = newCcv;
      });
    } else {
      _showValidationError('Corrija os erros no cartão de crédito.');
    }
  }

  bool _isValidCreditCardDetails(int numCCard, int valCard, int ccv) {
    if (numCCard.toString().length != 16) {
      _showValidationError('O número do cartão de crédito deve ter exatamente 16 dígitos.');
      return false;
    }

    if (valCard.toString().length != 4) {
      _showValidationError('A validade do cartão de crédito deve ter exatamente 4 dígitos.');
      return false;
    }
    
    if (valCard < 2024 || valCard > 2100) {
      _showValidationError('Cartão de crédito expirou ou ano invalido.');
      return false;
    }

    if (ccv.toString().length != 3) {
      _showValidationError('O código de segurança do cartão de crédito (CCV) deve ter exatamente 3 dígitos.');
      return false;
    }

    return true;
  }

  void _showValidationError(String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro de Validação'),
          content: Text(error),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
