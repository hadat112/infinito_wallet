class Wallet {
  Wallet({
    this.amount = 0,
    this.coin,
    required this.imageUrl,
  });

  // receiving data from server
  factory Wallet.fromMap(dynamic map) {
    return Wallet(amount: map['amount'], imageUrl: map['imageUrl']);
  }

  double amount;
  String imageUrl;
  String? coin;

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {'amount': amount, 'imageUrl': imageUrl};
  }
}
