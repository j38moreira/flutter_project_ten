class Atividade {
  String nomeProduto;
  DateTime dataEntrega;
  double pesoProduto;
  double profundidadeProduto;
  double larguraProduto;
  double alturaProduto;
  String locRemetente;
  String locDestino;
  double custo;

  Atividade(
    this.nomeProduto,
    this.dataEntrega,
    this.pesoProduto,
    this.profundidadeProduto,
    this.larguraProduto,
    this.alturaProduto,
    this.locRemetente,
    this.locDestino, {
    this.custo = 0.0,
  });
}
