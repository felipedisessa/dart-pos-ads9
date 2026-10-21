import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/janela_cadastro.dart';
import 'package:flutter_application_2/janela_pets.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Garante a inicialização correta dos Widgets do Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // SE ESTIVER RODANDO NO WINDOWS OU LINUX, INICIALIZA O MOTOR FFI
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Cada aba é uma "janela" do app
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Pets'),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.add), text: 'Cadastro'),
                Tab(icon: Icon(Icons.pets), text: 'Pets cadastrados'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              JanelaCadastro(),
              JanelaPets(),
            ],
          ),
        ),
      ),
    );
  }
}
