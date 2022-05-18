class Wallet {
  Wallet({this.amount});

  // receiving data from server
  factory Wallet.fromMap(dynamic map) {
    return Wallet(
      amount: map['amount']
    );
  }

  double? amount;

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'amount': amount
    };
  }
}