import 'atividade.dart';

class User {
  int idUser;
  String nome;
  String email;
  String pwd;
  int numCCard;
  int valCard;
  int ccv;
  String imgUser;
  List<Atividade> atvHistorico;

  User(
    this.idUser,
    this.nome,
    this.email,
    this.pwd,
    this.numCCard,
    this.valCard,
    this.ccv,
    this.imgUser,
    this.atvHistorico,
  ) {
    if (numCCard != 0 || valCard != 0 || ccv != 0) {
      _validateCreditCardFields();
    }
  }

  bool get hasCreditCard =>
      numCCard != 0 && valCard != 0 && ccv != 0;

  void _validateCreditCardFields() {
    if (numCCard.toString().length != 16) {
      throw ArgumentError('O número do cartão de crédito deve ter exatamente 16 dígitos.');
    }
    if (valCard.toString().length != 4 || valCard < 2024 || valCard > 2100) {
      throw ArgumentError('A validade do cartão de crédito deve ter exatamente 4 dígitos e estar no intervalo de 2024 a 2100.');
    }
    if (ccv.toString().length != 3) {
      throw ArgumentError('O código de segurança do cartão de crédito (CCV) deve ter exatamente 3 dígitos.');
    }
  }
}
