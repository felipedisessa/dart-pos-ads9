import 'package:flutter/material.dart';
import 'package:flutter_application_2/helper.dart';
import 'package:flutter_application_2/janela_editar.dart';

// JANELA 2: LISTA DOS PETS CADASTRADOS
class JanelaPets extends StatefulWidget {
  const JanelaPets({super.key});

  @override
  State<JanelaPets> createState() => _JanelaPetsState();
}

class _JanelaPetsState extends State<JanelaPets> {
  Future<void> apagar(Map<String, dynamic> pet) async {
    await DatabaseHelper.apagarCao(pet['id']);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${pet['nome']} apagado.')),
    );

    // setState faz o FutureBuilder buscar a lista de novo
    setState(() {});
  }

  Future<void> editar(Map<String, dynamic> pet) async {
    // Abre a janela de edição e espera ela fechar
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => JanelaEditar(pet: pet)),
    );

    // Atualiza a lista com os dados alterados
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      // Chama a função que busca os dados no banco
      future: DatabaseHelper.buscarTodos(),
      builder: (context, snapshot) {
        // 1. Enquanto o banco está carregando os dados do disco
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // 2. Se houver algum erro na busca
        if (snapshot.hasError) {
          return Center(
              child: Text('Erro ao carregar dados: ${snapshot.error}'));
        }

        // 3. Se não houver nenhum pet cadastrado ainda
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Nenhum pet cadastrado.'));
        }

        // 4. Se encontrou dados, armazena na variável 'listaPets'
        final listaPets = snapshot.data!;

        return SingleChildScrollView(
          child: Column(
            children: listaPets.map((pet) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Pet: ${pet['nome']}'),
                    Text('Dono: ${pet['dono']}'),
                    Text('Idade: ${pet['idade']}'),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      tooltip: 'Alterar',
                      onPressed: () => editar(pet),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      tooltip: 'Apagar',
                      onPressed: () => apagar(pet),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
