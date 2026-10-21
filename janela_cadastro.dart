import 'package:flutter/material.dart';
import 'package:flutter_application_2/helper.dart';

// JANELA 1: CADASTRO DE PETS
class JanelaCadastro extends StatefulWidget {
  const JanelaCadastro({super.key});

  @override
  State<JanelaCadastro> createState() => _JanelaCadastroState();
}

class _JanelaCadastroState extends State<JanelaCadastro> {
  TextEditingController controlaNome = TextEditingController();
  TextEditingController controlaDono = TextEditingController();
  TextEditingController controlaIdade = TextEditingController();

  Future<void> salvarNoBanco() async {
    // Monta o mapa com os dados no formato que a tabela espera
    Map<String, dynamic> novoCao = {
      'nome': controlaNome.text,
      'dono': controlaDono.text,
      'idade': int.tryParse(controlaIdade.text) ?? 0,
    };

    // Salva no banco de dados local usando nossa classe auxiliar
    await DatabaseHelper.inserirCao(novoCao);

    // Feedback
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${controlaNome.text} salvo com sucesso!')),
    );

    // Limpa os campos para o próximo cadastro
    controlaNome.clear();
    controlaDono.clear();
    controlaIdade.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          onPressed: salvarNoBanco,
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
