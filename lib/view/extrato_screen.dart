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
  List<Transacoes> _transacoes = [];

  @override
  void initState() {
    super.initState();
    _getTransacoes();
  }

  void _getTransacoes() async {
    //Dio dio = Dio();
    try {
      final response = await Dio().get(
        'http://192.168.0.79:8080/transaction/$_transacoes',
        queryParameters: {'accountId': widget.account1},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        List<Transacoes> transacoes =
            data.map((item) => Transacoes.fromJson(item)).toList();

        transacoes.sort(
          (a, b) => b.id!.compareTo(a.id!),
        );

        setState(() {
          _transacoes = transacoes;
        });

        debugPrint('dados: $transacoes');
      } else {}
    } catch (error) {}
  }

  List<Widget> buildTransacoesList() {
    return _transacoes.map((transacao) {
      return ListTile(
        title: Text('Tipo: ${transacao.type}'),
        subtitle: Text('Valor: ${transacao.balance}'),
      );
    }).toList();
  }

  @override
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: const Text('Extrato'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Histórico',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: buildTransacoesList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
