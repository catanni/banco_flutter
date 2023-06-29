import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../model/transacoes.dart';

class SaqueScreen extends StatefulWidget {
  final dynamic account1;

  SaqueScreen({this.account1});

  @override
  _SaqueScreenState createState() => _SaqueScreenState();
}

class _SaqueScreenState extends State<SaqueScreen> {
  TextEditingController _valorController = TextEditingController();

  @override
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }

  void _updateBalance(BuildContext context) async {
    String balance = _valorController.text;
    double? balanceParsed = double.tryParse(balance);
    double balanceParsedClass = double.parse(widget.account1['balance']);

    double newBalance = balanceParsedClass - double.tryParse(balance)!;

    if (balanceParsed == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Valor inválido'),
            content: const Text('O valor de saque informado não é válido.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }
    if (balanceParsed > double.parse(widget.account1!['balance'])) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Saldo insuficiente'),
            content: const Text(
                'Você não possui saldo suficiente para realizar esse saque.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    setState(() {
      balanceParsedClass -= double.tryParse(balance)!;
    });

    widget.account1['balance'] = newBalance.toString();
    try {
      Dio dio = Dio();
      await dio.put(
        'http://192.168.0.79:8080/1',
        data: {
          'balance': widget.account1['balance'],
        },
      );
      Response response = await dio.post('http://192.168.0.79:8080/transaction',
          data: {
            'id': 'null',
            'accountId': widget.account1['id'],
            'type': TypeTransaction.SAQUE.descricao,
            'balance': widget.account1['balance']
          },
          options: Options(headers: {'Content-Type': 'application/json'}));
      print(response);
    } catch (error) {
      print('Erro na requisição: $error');
    }

    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Saque realizado'),
        content: const Text('O saque foi realizado com sucesso!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saque'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Informe o valor do Saque:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                controller: _valorController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text("Valor do Saque"),
                  labelStyle: TextStyle(color: Colors.white, fontSize: 24),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.black),
                  child: const Text('Confirmar'),
                  onPressed: () => _updateBalance(context),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.black),
                  child: const Text('Cancelar'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
