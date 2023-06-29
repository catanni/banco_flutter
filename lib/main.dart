import 'package:atm_project/view/authentication.dart';

import 'package:atm_project/view/deposit.dart';
import 'package:atm_project/view/extrato_screen.dart';
import 'package:atm_project/view/home_screen.dart';
import 'package:atm_project/view/saque_screen.dart';
import 'package:atm_project/view/transferencia_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ATMApp());
}

class ATMApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ATM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
      ),
      initialRoute: '/ATMScreen',
      routes: {
        '/ATMScreen': (context) => ATMScreen(),
        '/home': (context) => HomeScreen(),
        '/deposit': (context) => DepositoScreen(),
        '/saque': (context) => SaqueScreen(),
        '/extrato': (context) => ExtratoScreen(),
        '/transferencia': (context) => TransferenciaScreen(),
      },
    );
  }
}
