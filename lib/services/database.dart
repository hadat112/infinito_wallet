import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  DatabaseService({required this.uid});
  
  final String uid;


  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  late final Query<Map<String, dynamic>> walletDoc;

  void init() {
    walletDoc = FirebaseFirestore.instance
        .collection('wallet')
        .where('uid', isEqualTo: uid);
  }

  Future<dynamic> updateUserData(String name) async {
    return users.doc(uid).set({
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
  
  Future<String> getTransactionPassword() async {
    final snapshot = await users.doc(uid).get();
    return snapshot.get('transactionPassword');
  }

  Future<bool> addCoin(String id, double amount) async {
  try {
    final value = amount;
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('wallet')
        .doc(id);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final DocumentSnapshot snapshot = await transaction.get(documentReference);
      if (!snapshot.exists) {
        await documentReference.set({'amount': value});
        return true;
      }
      final double newAmount = snapshot.get('amount') + value;
      transaction.update(documentReference, {'amount': newAmount});
      return true;
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> removeCoin(String id) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('wallet')
      .doc(id)
      .delete();
  return true;
}

Future<void> changeName(String newName, String field) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .update({
      field: newName
    });
}
}
