import 'package:flutter/material.dart';

import '../models/dica.dart';

class DicaCard extends StatelessWidget {
  const DicaCard({super.key, required this.dica, this.onTap});

  final Dica dica;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final cores = tema.colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (dica.categoriaNome != null)
                    Flexible(
                      child: Text(
                        dica.categoriaNome!.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        style: tema.textTheme.labelSmall?.copyWith(
                          color: cores.primary,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  const Spacer(),
                  if (dica.dataFormatada != null)
                    Text(
                      dica.dataFormatada!,
                      style: tema.textTheme.labelSmall?.copyWith(
                        color: cores.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                dica.titulo,
                style: tema.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                dica.conteudo,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: tema.textTheme.bodyMedium?.copyWith(
                  color: cores.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
