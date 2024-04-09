import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/postes.dart';
import 'package:http/http.dart' as http;

Future<Postes> buscaPOSTE(int numero) async {
  final resposta = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$numero'));

  if (resposta.statusCode == 200) {
    // 200 é OK
    return Postes.fromJson(jsonDecode(resposta.body) as Map<String, dynamic>);
  } else {
    throw Exception('Falha ao carregar poste.');
  }
}

class NovaTela extends StatefulWidget {
  const NovaTela({super.key});

  @override
  State<NovaTela> createState() => _NovaTelaState();
}

class _NovaTelaState extends State<NovaTela> {
  late Future<Postes> futuroPoste;
  int contador = 1;

  void novoPoste() {
    setState(() {
      contador++;
      futuroPoste = buscaPOSTE(contador);
    });
  }

  @override
  void initState() {
    super.initState();
    futuroPoste = buscaPOSTE(4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mostrando Postes'),
        ),
        body: Column(children: [
          Center(
            child: FutureBuilder<Postes>(
              future: futuroPoste,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!.titulo);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
          ElevatedButton(
            onPressed: novoPoste,
            child: Text('Novo Poste'),
          ),
        ]));
  }
}
