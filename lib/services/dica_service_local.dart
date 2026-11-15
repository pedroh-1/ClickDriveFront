import '../models/categoria_dica.dart';
import '../models/dica.dart';
import 'dica_service.dart';

/// Dados de exemplo enquanto a integração com a API não é feita.
class DicaServiceLocal implements DicaService {
  const DicaServiceLocal({this.atraso = const Duration(milliseconds: 300)});

  /// Simula o tempo de resposta do servidor.
  final Duration atraso;

  static const _categorias = [
    CategoriaDica(id: 1, nome: 'Direção defensiva'),
    CategoriaDica(id: 2, nome: 'Legislação'),
    CategoriaDica(id: 3, nome: 'Prova prática'),
    CategoriaDica(id: 4, nome: 'Manutenção'),
  ];

  static final _dicas = [
    Dica(
      id: 1,
      titulo: 'Mantenha distância segura',
      conteudo:
          'Use a regra dos dois segundos: escolha um ponto fixo e conte dois '
          'segundos depois que o veículo da frente passar por ele. Com chuva, '
          'dobre esse tempo.',
      dataPublicacao: DateTime(2026, 11, 10, 9),
      categoriaId: 1,
      categoriaNome: 'Direção defensiva',
    ),
    Dica(
      id: 2,
      titulo: 'Preferência na rotatória',
      conteudo:
          'Quem já está circulando na rotatória tem preferência, salvo '
          'sinalização em contrário (art. 29 do CTB).',
      dataPublicacao: DateTime(2026, 11, 8, 14, 30),
      categoriaId: 2,
      categoriaNome: 'Legislação',
    ),
    Dica(
      id: 3,
      titulo: 'Ajuste os retrovisores antes de sair',
      conteudo:
          'Na prova prática o examinador observa se você regula banco, cinto '
          'e retrovisores antes de ligar o carro.',
      dataPublicacao: DateTime(2026, 11, 5, 10, 15),
      categoriaId: 3,
      categoriaNome: 'Prova prática',
    ),
    const Dica(
      id: 4,
      titulo: 'Calibre os pneus com o carro frio',
      conteudo:
          'Pneus calibrados economizam combustível e melhoram a frenagem. '
          'Confira a pressão a cada 15 dias.',
      categoriaId: 4,
      categoriaNome: 'Manutenção',
    ),
    Dica(
      id: 5,
      titulo: 'Sinalize sempre',
      conteudo:
          'Ligue a seta antes de mudar de faixa ou converter, mesmo sem outros '
          'veículos por perto.',
      dataPublicacao: DateTime(2026, 10, 30, 8),
      categoriaId: 3,
      categoriaNome: 'Prova prática',
    ),
    Dica(
      id: 6,
      titulo: 'Celular ao volante é infração gravíssima',
      conteudo:
          'Segurar ou manusear o celular enquanto dirige gera multa e 7 pontos '
          'na CNH (art. 252 do CTB).',
      dataPublicacao: DateTime(2026, 10, 25, 16),
      categoriaId: 2,
      categoriaNome: 'Legislação',
    ),
  ];

  @override
  Future<List<CategoriaDica>> listarCategorias() async {
    await Future<void>.delayed(atraso);
    return List.of(_categorias);
  }

  @override
  Future<List<Dica>> listarDicas({int? categoriaId}) async {
    await Future<void>.delayed(atraso);
    return _dicas
        .where((d) => categoriaId == null || d.categoriaId == categoriaId)
        .toList();
  }
}
