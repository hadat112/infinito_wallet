import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infinito_wallet/models/wallet.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  late final Query<Map<String, dynamic>> walletDoc;

  void init() {
    walletDoc = FirebaseFirestore.instance
        .collection("wallet")
        .where("uid", isEqualTo: uid);
  }

  Future updateUserData(String name) async {
    return await users.doc(uid).set({
      'name': name,
    });
  }

  Future<String> getWalletID() async {
    init();
    String s = '';
    await walletDoc.get().then((snapshot) {
      // print(snapshot.docs[0].id);
      s = snapshot.docs[0].id;
    });
    return s;
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

  // // wallet from snapshot
  Future getUserWallet() async {
    init();
    Wallet wallet = Wallet(wallet_name: '', name: 'name', amount: 0);
    await walletDoc.get().then((snapshot) {
      wallet = Wallet(
          wallet_name: snapshot.docs[0].get('wallet_name'),
          name: snapshot.docs[0].get('name'),
          amount: snapshot.docs[0].get('amount').toDouble());
    });
    return wallet;
  }

  // get brews stream
  Stream<Wallet> get wallet {
    init();
    StreamController<Wallet> controller = StreamController<Wallet>();
    
    return controller.stream;
  }

  Future<bool> addCoin(String id, double amount) async {
  try {
    var value = amount;
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('wallet')
        .doc(id);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        documentReference.set({'amount': value});
        return true;
      }
      double newAmount = snapshot.get('amount') + value;
      transaction.update(documentReference, {'amount': newAmount});
      return true;
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> removeCoin(String id) async {
  FirebaseFirestore.instance
      .collection('Users')
      .doc(uid)
      .collection('Coins')
      .doc(id)
      .delete();
  return true;
}
}
