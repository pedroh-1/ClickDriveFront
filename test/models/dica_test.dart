import 'package:clickdrive_front/models/dica.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('converte DicaResponseDTO da API', () {
    final dica = Dica.fromJson({
      'id': 1,
      'titulo': 'Use o cinto',
      'conteudo': 'Sempre, inclusive no banco de trás.',
      'dataPublicacao': '2026-11-05T14:30:00',
      'categoriaDicaId': 2,
      'categoriaDicaNome': 'Segurança',
    });

    expect(dica.id, 1);
    expect(dica.titulo, 'Use o cinto');
    expect(dica.categoriaId, 2);
    expect(dica.categoriaNome, 'Segurança');
    expect(dica.dataFormatada, '05/11/2026');
  });

  test('aceita dica sem data e sem categoria', () {
    final dica = Dica.fromJson({
      'id': 3,
      'titulo': 'Sinalize',
      'conteudo': 'Use a seta.',
      'dataPublicacao': null,
      'categoriaDicaId': null,
      'categoriaDicaNome': null,
    });

    expect(dica.dataPublicacao, isNull);
    expect(dica.dataFormatada, isNull);
    expect(dica.categoriaNome, isNull);
  });
}
