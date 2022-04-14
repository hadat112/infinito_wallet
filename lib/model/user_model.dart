class UserModel {
  String? uid;
  String? email;
  String? country;
  String? transactionPassword;

  UserModel({this.uid, this.email, this.country, this.transactionPassword});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      country: map['country'],
      transactionPassword: map['transactionPassword']
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'country': country,
      'transactionPassword': transactionPassword,
    };
  }
}