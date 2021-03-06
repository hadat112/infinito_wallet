class UserModel {
  UserModel({this.uid, this.email, this.country, this.transactionPassword, this.name, this.walletName});

  // receiving data from server
  factory UserModel.fromMap(dynamic map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      country: map['country'],
      transactionPassword: map['transactionPassword'],
      name: map['name'],
      walletName: map['wallet_name']
    );
  }

  String? uid;
  String? email;
  String? name;
  String? walletName;
  String? country;
  String? transactionPassword;

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'country': country,
      'transactionPassword': transactionPassword,
      'name': name,
      'wallet_name': walletName,
    };
  }
}