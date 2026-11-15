/// Espelha o `DicaResponseDTO` da API.
class Dica {
  const Dica({
    required this.id,
    required this.titulo,
    required this.conteudo,
    this.dataPublicacao,
    this.categoriaId,
    this.categoriaNome,
  });

  final int id;
  final String titulo;
  final String conteudo;
  final DateTime? dataPublicacao;
  final int? categoriaId;
  final String? categoriaNome;

  factory Dica.fromJson(Map<String, dynamic> json) {
    final data = json['dataPublicacao'];
    return Dica(
      id: (json['id'] as num).toInt(),
      titulo: json['titulo'] as String,
      conteudo: json['conteudo'] as String,
      // LocalDateTime chega como "2026-11-15T14:30:00"
      dataPublicacao: data is String ? DateTime.tryParse(data) : null,
      categoriaId: (json['categoriaDicaId'] as num?)?.toInt(),
      categoriaNome: json['categoriaDicaNome'] as String?,
    );
  }

  /// Data no formato dd/MM/yyyy, ou null se a dica não tiver data.
  String? get dataFormatada {
    final data = dataPublicacao;
    if (data == null) return null;
    String doisDigitos(int n) => n.toString().padLeft(2, '0');
    return '${doisDigitos(data.day)}/${doisDigitos(data.month)}/${data.year}';
  }
}
