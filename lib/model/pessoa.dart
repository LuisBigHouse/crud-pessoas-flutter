class Pessoa {
  final int? id;
  final int idade;
  final String nome;

  Pessoa({
    this.id,
    required this.idade,
    required this.nome,
  });

  factory Pessoa.fromJson(Map<String, dynamic> json) {
    return Pessoa(
      id: json['id'],
      idade: json['idade'],
      nome: json['nome'],
    );
  }
  List<Object> get props => [
        id!,
        idade,
        nome,
      ];
}
