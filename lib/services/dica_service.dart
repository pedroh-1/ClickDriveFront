import '../models/categoria_dica.dart';
import '../models/dica.dart';

/// Fonte de dados das dicas (RF04).
///
/// Hoje a tela usa [DicaServiceLocal]. Na integração com a clickDriveAPI,
/// basta criar uma implementação que chame `GET /dicas/categorias`,
/// `GET /dicas` e `GET /dicas/categoria/{id}`.
abstract class DicaService {
  Future<List<CategoriaDica>> listarCategorias();

  /// Todas as dicas, ou só as da categoria informada.
  Future<List<Dica>> listarDicas({int? categoriaId});
}
