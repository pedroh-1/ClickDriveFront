import 'package:flutter/material.dart';

import '../../models/categoria_dica.dart';
import '../../models/dica.dart';
import '../../services/dica_service.dart';
import '../../services/dica_service_local.dart';
import '../../widgets/dica_card.dart';
import 'dica_detalhe_screen.dart';

/// RF04 - Visualização de dicas de trânsito organizadas por categoria.
class DicasScreen extends StatefulWidget {
  const DicasScreen({super.key, this.service = const DicaServiceLocal()});

  final DicaService service;

  @override
  State<DicasScreen> createState() => _DicasScreenState();
}

class _DicasScreenState extends State<DicasScreen> {
  List<CategoriaDica> _categorias = [];
  List<Dica> _dicas = [];
  int? _categoriaSelecionada;
  String _busca = '';
  bool _carregando = true;
  String? _erro;

  // Evita que uma resposta antiga sobrescreva a da categoria selecionada depois
  int _requisicaoAtual = 0;

  @override
  void initState() {
    super.initState();
    _carregarTudo();
  }

  Future<void> _carregarTudo() async {
    final requisicao = ++_requisicaoAtual;
    setState(() {
      _carregando = true;
      _erro = null;
    });
    try {
      final resultados = await Future.wait([
        widget.service.listarCategorias(),
        widget.service.listarDicas(categoriaId: _categoriaSelecionada),
      ]);
      if (!mounted || requisicao != _requisicaoAtual) return;
      setState(() {
        _categorias = resultados[0] as List<CategoriaDica>;
        _dicas = resultados[1] as List<Dica>;
        _carregando = false;
      });
    } catch (_) {
      if (!mounted || requisicao != _requisicaoAtual) return;
      setState(() {
        _erro = 'Não foi possível carregar as dicas.';
        _carregando = false;
      });
    }
  }

  Future<void> _carregarDicas() async {
    final requisicao = ++_requisicaoAtual;
    setState(() {
      _carregando = true;
      _erro = null;
    });
    try {
      final dicas = await widget.service.listarDicas(
        categoriaId: _categoriaSelecionada,
      );
      if (!mounted || requisicao != _requisicaoAtual) return;
      setState(() {
        _dicas = dicas;
        _carregando = false;
      });
    } catch (_) {
      if (!mounted || requisicao != _requisicaoAtual) return;
      setState(() {
        _erro = 'Não foi possível carregar as dicas.';
        _carregando = false;
      });
    }
  }

  void _selecionarCategoria(int? id) {
    if (id == _categoriaSelecionada) return;
    setState(() => _categoriaSelecionada = id);
    _carregarDicas();
  }

  List<Dica> get _dicasFiltradas {
    final termo = _busca.trim().toLowerCase();
    if (termo.isEmpty) return _dicas;
    return _dicas
        .where(
          (d) =>
              d.titulo.toLowerCase().contains(termo) ||
              d.conteudo.toLowerCase().contains(termo),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dicas de trânsito')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Buscar dica',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onChanged: (valor) => setState(() => _busca = valor),
                  ),
                ),
                _buildCategorias(),
                const SizedBox(height: 4),
                Expanded(child: _buildConteudo()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategorias() {
    if (_categorias.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _chip(null, 'Todas'),
          for (final categoria in _categorias)
            _chip(categoria.id, categoria.nome),
        ],
      ),
    );
  }

  Widget _chip(int? id, String rotulo) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(rotulo),
        selected: _categoriaSelecionada == id,
        onSelected: (_) => _selecionarCategoria(id),
      ),
    );
  }

  Widget _buildConteudo() {
    if (_carregando) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_erro != null) {
      return _Mensagem(
        icone: Icons.cloud_off,
        texto: _erro!,
        acao: FilledButton.icon(
          onPressed: _carregarTudo,
          icon: const Icon(Icons.refresh),
          label: const Text('Tentar novamente'),
        ),
      );
    }

    final dicas = _dicasFiltradas;
    if (dicas.isEmpty) {
      return RefreshIndicator(
        onRefresh: _carregarTudo,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const SizedBox(height: 48),
            _Mensagem(
              icone: Icons.lightbulb_outline,
              texto: _busca.trim().isNotEmpty
                  ? 'Nenhuma dica encontrada para "${_busca.trim()}".'
                  : 'Nenhuma dica cadastrada nesta categoria.',
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _carregarTudo,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        itemCount: dicas.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final dica = dicas[index];
          return DicaCard(
            dica: dica,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => DicaDetalheScreen(dica: dica)),
            ),
          );
        },
      ),
    );
  }
}

class _Mensagem extends StatelessWidget {
  const _Mensagem({required this.icone, required this.texto, this.acao});

  final IconData icone;
  final String texto;
  final Widget? acao;

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icone, size: 48, color: cores.outline),
            const SizedBox(height: 12),
            Text(
              texto,
              textAlign: TextAlign.center,
              style: TextStyle(color: cores.onSurfaceVariant),
            ),
            if (acao != null) ...[const SizedBox(height: 16), acao!],
          ],
        ),
      ),
    );
  }
}
