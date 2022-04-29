import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infinito_wallet/models/wallet.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference walletCollection =
      FirebaseFirestore.instance.collection('wallet');

  Future updateUserData(double amount, String name) async {
    return await walletCollection.doc(uid).set({
      'amount': amount,
      'name': name,
    });
  }

  Future getUser(String uid) async {
    return await walletCollection.doc(uid).snapshots().map((doc) {
      _userDataFromSnapshot(doc);
    });
  }

  // userData from snapshot
  Wallet _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return Wallet(
      amount: snapshot.get('field'),
      name: snapshot.get('name'),
    );
  }

  // brew list from snapshot
  Wallet _brewListFromSnapshot(DocumentSnapshot doc) {
    print(uid);
      return Wallet(
        name: doc.get('name') ?? '',
        amount: doc.get('amount') ?? 0,
      );
  }

  // get brews stream
  Stream<Wallet> get wallets {
    return walletCollection.doc(uid).snapshots().map(_brewListFromSnapshot);
  }
}
