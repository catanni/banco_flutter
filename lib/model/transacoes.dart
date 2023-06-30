import 'dart:convert';

class Transacoes {
  int? id;
  int accountId;
  String type;
  String balance;

  Transacoes(
      {this.id,
      required this.accountId,
      required this.type,
      required this.balance});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'accountId': accountId,
      'type': type,
      'balance': balance,
    };
  }

  factory Transacoes.fromMap(Map<String, dynamic> map) {
    return Transacoes(
      id: map['id'] as int,
      accountId: map['accountId'] as int,
      type: map['type'] as String,
      balance: map['balance'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Transacoes.fromJson(String source) =>
      Transacoes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transacoes(id: $id, accountId: $accountId, type: $type, balance: $balance)';
  }
}

enum TypeTransaction {
  DEPOSITO,
  TRANSFERENCIA,
  SAQUE,
}

extension TipoTransacaoExtension on TypeTransaction {
  String get descricao {
    switch (this) {
      case TypeTransaction.DEPOSITO:
        return 'Depósito';
      case TypeTransaction.TRANSFERENCIA:
        return 'Transferência';
      case TypeTransaction.SAQUE:
        return 'Saque';
    }
  }
}
