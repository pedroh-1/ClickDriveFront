import 'package:clickdrive_front/models/categoria_dica.dart';
import 'package:clickdrive_front/models/dica.dart';
import 'package:clickdrive_front/screens/dicas/dicas_screen.dart';
import 'package:clickdrive_front/services/dica_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _dicas = [
  Dica(
    id: 1,
    titulo: 'Use o cinto',
    conteudo: 'Sempre, inclusive no banco de trás.',
    categoriaId: 1,
    categoriaNome: 'Segurança',
  ),
  Dica(
    id: 2,
    titulo: 'Preferência na rotatória',
    conteudo: 'Quem já está na rotatória tem preferência.',
    categoriaId: 2,
    categoriaNome: 'Legislação',
  ),
];

class _FakeDicaService implements DicaService {
  _FakeDicaService({this.falhar = false});

  bool falhar;
  final pedidos = <int?>[];

  @override
  Future<List<CategoriaDica>> listarCategorias() async {
    if (falhar) throw Exception('falha');
    return const [
      CategoriaDica(id: 1, nome: 'Segurança'),
      CategoriaDica(id: 2, nome: 'Legislação'),
    ];
  }

  @override
  Future<List<Dica>> listarDicas({int? categoriaId}) async {
    pedidos.add(categoriaId);
    if (falhar) throw Exception('falha');
    return _dicas
        .where((d) => categoriaId == null || d.categoriaId == categoriaId)
        .toList();
  }
}

Widget _app(DicaService service) =>
    MaterialApp(home: DicasScreen(service: service));

void main() {
  testWidgets('lista dicas e filtra por categoria', (tester) async {
    final service = _FakeDicaService();
    await tester.pumpWidget(_app(service));
    await tester.pumpAndSettle();

    expect(find.text('Use o cinto'), findsOneWidget);
    expect(find.text('Preferência na rotatória'), findsOneWidget);

    await tester.tap(find.widgetWithText(ChoiceChip, 'Legislação'));
    await tester.pumpAndSettle();

    expect(service.pedidos.last, 2);
    expect(find.text('Use o cinto'), findsNothing);
    expect(find.text('Preferência na rotatória'), findsOneWidget);
  });

  testWidgets('busca filtra pelo texto', (tester) async {
    await tester.pumpWidget(_app(_FakeDicaService()));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'cinto');
    await tester.pump();

    expect(find.text('Use o cinto'), findsOneWidget);
    expect(find.text('Preferência na rotatória'), findsNothing);

    await tester.enterText(find.byType(TextField), 'xyz');
    await tester.pump();
    expect(find.textContaining('Nenhuma dica encontrada'), findsOneWidget);
  });

  testWidgets('abre o detalhe ao tocar na dica', (tester) async {
    await tester.pumpWidget(_app(_FakeDicaService()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Use o cinto'));
    await tester.pumpAndSettle();

    expect(find.text('Dica'), findsOneWidget);
    expect(find.text('Sempre, inclusive no banco de trás.'), findsOneWidget);
  });

  testWidgets('mostra erro e tenta novamente', (tester) async {
    final service = _FakeDicaService(falhar: true);
    await tester.pumpWidget(_app(service));
    await tester.pumpAndSettle();

    expect(find.text('Não foi possível carregar as dicas.'), findsOneWidget);

    service.falhar = false;
    await tester.tap(find.text('Tentar novamente'));
    await tester.pumpAndSettle();

    expect(find.text('Use o cinto'), findsOneWidget);
  });
}
