import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/transacoes.dart';

class ExtratoScreen extends StatefulWidget {
  final dynamic account1;

  ExtratoScreen({this.account1});

  @override
  _ExtratoScreenState createState() => _ExtratoScreenState();
}

class _ExtratoScreenState extends State<ExtratoScreen> {
  TextEditingController _valorController = TextEditingController();
  List<dynamic> _transacoes = [];

  @override
  void initState() {
    super.initState();
    _getTransacoes();
  }

  void _getTransacoes() async {
    Dio dio = Dio();
    Response response = await dio.get('http://192.168.0.79:8080/transaction/1');
    List<dynamic> transacoes = response.data;

    setState(() {
      _transacoes = transacoes;
    });
  }

  @override
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[400],
      appBar: AppBar(
        title: Text('Extrato'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Histórico',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                    itemCount: _transacoes.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> mapaTransacoes = _transacoes[
                          index]; // Supondo que _transacoes seja uma lista de mapas

                      // Converta o mapa para uma instância de Transacoes
                      Transacoes transacoes = Transacoes(
                        accountId: widget.account1['id'],
                        type: mapaTransacoes['type'],
                        balance: mapaTransacoes['balance'].toString(),
                      );

                      return ListTile(
                        titleTextStyle: const TextStyle(fontSize: 20),
                        subtitleTextStyle: const TextStyle(fontSize: 18),
                        title: Text('Tipo: ${transacoes.type}'),
                        subtitle: Text('Valor: R\$ ${transacoes.balance}'),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
