import 'package:atm_project/model/transacoes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DepositoScreen extends StatefulWidget {
  final dynamic account1;

  DepositoScreen({this.account1});

  @override
  _DepositoScreenState createState() => _DepositoScreenState();
}

class _DepositoScreenState extends State<DepositoScreen> {
  final TextEditingController _valorController = TextEditingController();

  @override
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }

  void _depositUser(BuildContext context) async {
    String balance = _valorController.text;
    double? balanceParsed = double.tryParse(balance);
    double balanceParsedClass = double.parse(widget.account1['balance']);

    double newBalance = double.tryParse(balance)! + balanceParsedClass;

    if (balanceParsed == null || balanceParsed == 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Valor inválido'),
            content: const Text('O valor de depósito informado não é válido.'),
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
      return; // Abortar a operação de depósito
    }

    setState(() {
      widget.account1['balance'] += balance;
    });

    widget.account1['balance'] = newBalance.toString();
    try {
      Dio dio = Dio();
      await dio.put(
        'http://192.168.0.79:8080/account/1',
        data: {
          'balance': widget.account1['balance'],
        },
      );
      Response response = await dio.post(
        'http://192.168.0.79:8080/transaction',
        data: {
          'id': '',
          'accountId': widget.account1['id'],
          'type': TypeTransaction.DEPOSITO.descricao,
          'balance': balance
        },
      );
      print(response);
    } catch (error) {
      print('Erro na requisição: $error');
    }

    //await DBHelper.inserirTransacoes(transacoes);

    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('O deposito foi realizado com sucesso!'),
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
        title: const Text('Depósito'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.deepPurple[400],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Informe o valor do depósito:',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                controller: _valorController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text("Valor do Depósito"),
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
                  onPressed: () => _depositUser(context),
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
