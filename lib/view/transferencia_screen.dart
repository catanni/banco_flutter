import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../model/transacoes.dart';

class TransferenciaScreen extends StatefulWidget {
  final dynamic account1;
  final dynamic account2;

  TransferenciaScreen({
    this.account1,
    this.account2,
  }) : super();

  @override
  State<TransferenciaScreen> createState() => _TransferenciaScreenState();
}

class _TransferenciaScreenState extends State<TransferenciaScreen> {
  TextEditingController _valorController = TextEditingController();
  dynamic account2;

  void initState() {
    super.initState();
    account2 = act();
  }

  Future<String> act() async {
    Dio dio = Dio();
    Response response = await dio.get('http://192.168.0.79:8080/account/2');
    var account2 = response.data['name'];
    return account2;
  }

  @override
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }

  void _transferFunds(BuildContext context) async {
    Dio dio = Dio();
    Response response = await dio.get('http://192.168.0.79:8080/account/2');
    var account2 = response.data;

    String balance = _valorController.text;
    double? balanceParsed = double.tryParse(balance);
    double currentBalance = double.parse(widget.account1['balance']);

    double? balanceAc2 = double.tryParse(account2['balance']);

    if (balanceParsed! > currentBalance) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erro'),
            content: const Text('Saldo insuficiente na conta de origem.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    setState(() {
      currentBalance -= double.tryParse(balance)!;
    });

    double newBalance = currentBalance - double.tryParse(balance)!;
    widget.account1['balance'] = newBalance.toString();
    double newBalance2 = balanceAc2! + double.tryParse(balance)!;

    try {
      Dio dio = Dio();
      await dio.put(
        'http://192.168.0.79:8080/account/1',
        data: {
          'balance': widget.account1['balance'],
        },
      );
      dio.put(
        'http://192.168.0.79:8080/account/2',
        data: {
          'balance': newBalance2,
        },
      );
      await dio.post(
        'http://192.168.0.79:8080/transaction',
        data: {
          'id': "",
          'accountId': widget.account1['id'],
          'type': TypeTransaction.TRANSFERENCIA.descricao,
          'balance': balance
        },
      );
    } catch (error) {
      debugPrint('Erro na requisição: $error');
    }

    // Exibir um diálogo de sucesso ou redirecionar para outra tela
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sucesso'),
          content: const Text('Transferência realizada com sucesso.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Transferencia'),
      ),
      backgroundColor: Colors.deepPurple[400],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _valorController,
                decoration: const InputDecoration(
                  label: Text("Valor da Transferência"),
                  labelStyle: TextStyle(color: Colors.white, fontSize: 30),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira o valor da transferência';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(0, 40),
                    backgroundColor: Colors.black),
                onPressed: () => _transferFunds(context),
                child: const Text(
                  'Transferir',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
