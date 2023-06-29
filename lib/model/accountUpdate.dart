class AccountUpdate {
  final int? id;
  final int? pin;
  final double? balance;

  const AccountUpdate(
      {required this.id, required this.pin, required this.balance});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pin': pin,
      'balance': balance,
    };
  }

  @override
  String toString() {
    return 'UsersModel{id: $id, pin: $pin, email: $balance}';
  }
}
