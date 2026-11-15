import 'package:clickdrive_front/services/dica_service_local.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const service = DicaServiceLocal(atraso: Duration.zero);

  test('lista categorias', () async {
    final categorias = await service.listarCategorias();
    expect(categorias, isNotEmpty);
  });

  test('filtra dicas pela categoria', () async {
    final todas = await service.listarDicas();
    final legislacao = await service.listarDicas(categoriaId: 2);

    expect(legislacao, isNotEmpty);
    expect(legislacao.length, lessThan(todas.length));
    expect(legislacao.every((d) => d.categoriaId == 2), isTrue);
  });

  test('toda dica aponta para uma categoria existente', () async {
    final ids = (await service.listarCategorias()).map((c) => c.id).toSet();
    final dicas = await service.listarDicas();
    expect(dicas.every((d) => ids.contains(d.categoriaId)), isTrue);
  });
}
