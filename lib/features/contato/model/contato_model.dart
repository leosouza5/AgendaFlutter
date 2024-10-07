class ContatoModel {
  ContatoModel({
    this.id,
    required this.nome,
    required this.numero,
    required this.email,
  });
  int? id;
  String nome;
  String numero;
  String email;
}
