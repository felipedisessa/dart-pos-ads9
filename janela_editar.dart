import 'package:flutter/material.dart';
import 'package:flutter_application_2/helper.dart';

// JANELA 3: ALTERAR OS DADOS DE UM PET JÁ SALVO
class JanelaEditar extends StatefulWidget {
  const JanelaEditar({super.key, required this.pet});

  // Registro que veio da lista (id, nome, dono, idade)
  final Map<String, dynamic> pet;

  @override
  State<JanelaEditar> createState() => _JanelaEditarState();
}

class _JanelaEditarState extends State<JanelaEditar> {
  late TextEditingController controlaNome;
  late TextEditingController controlaDono;
  late TextEditingController controlaIdade;

  @override
  void initState() {
    super.initState();
    // Os campos já começam preenchidos com os dados salvos
    controlaNome = TextEditingController(text: '${widget.pet['nome']}');
    controlaDono = TextEditingController(text: '${widget.pet['dono']}');
    controlaIdade = TextEditingController(text: '${widget.pet['idade']}');
  }

  Future<void> salvarAlteracoes() async {
    Map<String, dynamic> dados = {
      'nome': controlaNome.text,
      'dono': controlaDono.text,
      'idade': int.tryParse(controlaIdade.text) ?? 0,
    };

    await DatabaseHelper.atualizarCao(widget.pet['id'], dados);

    // Volta para a lista
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alterar ${widget.pet['nome']}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controlaNome,
              decoration: const InputDecoration(
                labelText: 'Nome do pet',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controlaDono,
              decoration: const InputDecoration(
                labelText: 'Nome do dono',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controlaIdade,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Idade do pet',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: salvarAlteracoes,
            child: const Text('Salvar alterações'),
          ),
        ],
      ),
    );
  }
}
