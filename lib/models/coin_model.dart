class CoinModel {
  CoinModel({this.amount});

  // receiving data from server
  factory CoinModel.fromMap(map) {
    return CoinModel(
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