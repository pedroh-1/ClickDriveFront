import 'package:flutter/material.dart';

import 'screens/dicas/dicas_screen.dart';

void main() {
  runApp(const ClickDriveApp());
}

class ClickDriveApp extends StatelessWidget {
  const ClickDriveApp({super.key});

  @override
  Widget build(BuildContext context) {
    const corBase = Color(0xFF1E5AA8);
    return MaterialApp(
      title: 'ClickDrive',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: corBase)),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: corBase,
          brightness: Brightness.dark,
        ),
      ),
      // Enquanto login e navegação por perfil não existem, abre direto nas dicas.
      home: const DicasScreen(),
    );
  }
}
