import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:infinito_wallet/Screens/Signup/SignUpPage.dart';
import 'package:infinito_wallet/models/user_model.dart';
import 'package:infinito_wallet/services/database.dart';

import '../Screens/Home/home.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // string for displaying the error Message
  String? errorMessage;

  // create user obj based on firebase user
  // UserModel? _userFromFirebaseUser(User user) {
  //   return user != null ? UserModel(uid: user.uid) : null;
  // }

  //  // auth change user stream
  // Stream<UserModel> get user {
  //   return _auth.authStateChanges()
  //     .map((User user) => _userFromFirebaseUser(user));

  // }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: 'Login Successful'),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Home())),
              });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'invalid-email':
          errorMessage = 'Your email address appears to be malformed.';
          break;
        case 'wrong-password':
          errorMessage = 'Your password is wrong.';
          break;
        case 'user-not-found':
          errorMessage = "User with this email doesn't exist.";
          break;
        case 'user-disabled':
          errorMessage = 'User with this email has been disabled.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many requests';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Signing in with Email and Password is not enabled.';
          break;
        default:
          errorMessage = 'An undefined Error happened.';
      }
      await Fluttertoast.showToast(msg: errorMessage!);
    }
  }

  Future signUp(String email, String password, String country,
      String transactionPassword, BuildContext context, bool loading) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) =>
              {postDetailsToFirestore(context, country, transactionPassword)})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message as String);
      });

      User? user = _auth.currentUser;
      String? userName = user!.email!.replaceAll('@gmail.com', '');
      await DatabaseService(uid: user.uid).updateUserData(0, userName);
    } on FirebaseAuthException catch (error) {
      await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignUpPage()),
        (route) => false);
      loading = false;
      switch (error.code) {
        case 'invalid-email':
          errorMessage = 'Your email address appears to be malformed.';
          break;
        case 'wrong-password':
          errorMessage = 'Your password is wrong.';
          break;
        case 'user-not-found':
          errorMessage = "User with this email doesn't exist.";
          break;
        case 'user-disabled':
          errorMessage = 'User with this email has been disabled.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many requests';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Signing in with Email and Password is not enabled.';
          break;
        default:
          errorMessage = 'An undefined Error happened.';
      }
      await Fluttertoast.showToast(msg: errorMessage!);
    }
  }

  void postDetailsToFirestore(
      BuildContext context, String country, String transactionPassword) async {
    // calling our firestore
    // calling our user model
    // sedning these values

    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    final UserModel userModel = UserModel();

    final User? user = _auth.currentUser;
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.country = country;
    userModel.transactionPassword = transactionPassword;

    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());
    await Fluttertoast.showToast(msg: 'Account created successfully :) ');

    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home()),
        (route) => false);
  }
}
