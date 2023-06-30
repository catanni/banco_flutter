import 'package:atm_project/view/saque_screen.dart';
import 'package:atm_project/view/transferencia_screen.dart';
import 'package:flutter/material.dart';

import 'deposit.dart';
import 'extrato_screen.dart';

class HomeScreen extends StatelessWidget {
  final dynamic account1;

  HomeScreen({this.account1});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150.0),
        child: AppBar(
          backgroundColor: Colors.deepPurple[400],
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0, left: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Olá, ${account1['name']}',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 8.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Conta',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'R\$ ${account1['balance']}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        minimumSize: const Size(50, 50),
                        backgroundColor: const Color.fromARGB(255, 44, 43, 43)),
                    child: const Icon(Icons.money, size: 40),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SaqueScreen(
                                  account1: account1,
                                )),
                      ).then((_) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              account1: account1,
                            ),
                          ),
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Saque',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        minimumSize: const Size(50, 50),
                        backgroundColor: const Color.fromARGB(255, 44, 43, 43)),
                    child: const Icon(Icons.attach_money, size: 40),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DepositoScreen(account1: account1)),
                      ).then((_) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              account1: account1,
                            ),
                          ),
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Deposito',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        minimumSize: const Size(50, 50),
                        backgroundColor: const Color.fromARGB(255, 44, 43, 43)),
                    child: const Icon(Icons.swap_horiz, size: 40),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TransferenciaScreen(account1: account1)),
                      ).then((_) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              account1: account1,
                            ),
                          ),
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Transferencia',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        minimumSize: const Size(50, 50),
                        backgroundColor: const Color.fromARGB(255, 44, 43, 43)),
                    child: const Icon(Icons.list, size: 40),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ExtratoScreen(account1: account1)),
                      ).then((_) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(
                              account1: account1,
                            ),
                          ),
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Extrato',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
