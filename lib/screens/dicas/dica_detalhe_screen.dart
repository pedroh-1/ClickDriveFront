import 'package:flutter/material.dart';

import '../../models/dica.dart';

class DicaDetalheScreen extends StatelessWidget {
  const DicaDetalheScreen({super.key, required this.dica});

  final Dica dica;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final cores = tema.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Dica')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    if (dica.categoriaNome != null)
                      Chip(
                        avatar: Icon(
                          Icons.label_outline,
                          size: 18,
                          color: cores.onSecondaryContainer,
                        ),
                        label: Text(dica.categoriaNome!),
                        backgroundColor: cores.secondaryContainer,
                        side: BorderSide.none,
                      ),
                    if (dica.dataFormatada != null)
                      Text(
                        'Publicada em ${dica.dataFormatada}',
                        style: tema.textTheme.bodySmall?.copyWith(
                          color: cores.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  dica.titulo,
                  style: tema.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                SelectableText(
                  dica.conteudo,
                  style: tema.textTheme.bodyLarge?.copyWith(height: 1.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
