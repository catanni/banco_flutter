class Account {
  final int id;
  final String name;
  final int pin;
  double balance;

  Account(
      {required this.id,
      required this.name,
      required this.pin,
      this.balance = 0.0});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'pin': pin,
      'balance': balance,
    };
  }

  @override
  String toString() {
    return 'UsersModel{id: $id, name: $name, pin: $pin, email: $balance}';
  }
}
