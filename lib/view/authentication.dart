import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/account_Model.dart';
import 'home_screen.dart';

class ATMScreen extends StatefulWidget {
  final Account? account1;
  final Account? account2;

  ATMScreen({this.account1, this.account2, super.key});

  @override
  _ATMScreenState createState() => _ATMScreenState();
}

class _ATMScreenState extends State<ATMScreen> {
  Account? account1;
  Account? account2;

  @override
  void initState() {
    super.initState();
    account1 = widget.account1;
    account2 = widget.account2;
  }

  void _login(BuildContext context) async {
    try {
      Dio dio = Dio();
      Response response = await dio.post(
        'http://192.168.0.79:8080/auth',
        data: {
          'name': "Bia",
          'pin': "123",
        },
      );
      print(response);
      if (response.statusCode == 200) {
        Response response = await dio.get('http://192.168.0.79:8080/account/1');
        await dio.get('http://192.168.0.79:8080/account/2');
        if (response.statusCode == 200) {
          print(response);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen(
                      account1: response.data,
                    )),
          );
        }
      } else {
        print('Erro ao criar usuário.');
      }
    } catch (error) {
      print('Erro na requisição: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const TextField(
                keyboardType: TextInputType.text,
                autofocus: true,
                style: TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                  label: Text("Nome"),
                  labelStyle: TextStyle(color: Colors.white, fontSize: 30),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const TextField(
                keyboardType: TextInputType.text,
                autofocus: true,
                obscureText: true,
                style: TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                  label: Text("Senha"),
                  labelStyle: TextStyle(color: Colors.white, fontSize: 30),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              ElevatedButton(
                  onPressed: () {
                    _login(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.75, 40),
                  ),
                  child: const Text(
                    'Entrar',
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
