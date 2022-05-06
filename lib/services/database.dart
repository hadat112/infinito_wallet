import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infinito_wallet/models/wallet.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(double amount, String name) async {
    return await users.doc(uid).collection('wallet').doc('wallet1').set({
      'amount': amount,
      'name': name,
    });
  }

  // Future getUser(String uid) async {
  //   return await users.doc(uid).collection('wallet').doc('wallet1').snapshots().map((doc) {
  //     _userDataFromSnapshot(doc);
  //   });
  // }

  // userData from snapshot
  Wallet _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return Wallet(
      wallet_name: snapshot.get('wallet_name') ?? '',
      amount: snapshot.get('field'),
      name: snapshot.get('name').toDouble(),
    );
  }

  // wallet from snapshot
  Wallet _walletListFromSnapshot(DocumentSnapshot doc) {
      return Wallet(
        wallet_name: doc.get('wallet_name') ?? '',
        name: doc.get('name') ?? '',
        amount: doc.get('amount').toDouble() ?? 0.0,
      );
  }

  // get brews stream
  Stream<Wallet> get wallet {
    return users.doc(uid).collection('wallet').doc('wallet1').snapshots().map(_walletListFromSnapshot);
  }
}