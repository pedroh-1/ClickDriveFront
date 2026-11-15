class CategoriaDica {
  const CategoriaDica({required this.id, required this.nome});

  final int id;
  final String nome;

  factory CategoriaDica.fromJson(Map<String, dynamic> json) {
    return CategoriaDica(
      id: (json['id'] as num).toInt(),
      nome: json['nome'] as String,
    );
  }
}
