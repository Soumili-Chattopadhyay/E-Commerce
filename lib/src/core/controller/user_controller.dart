// ignore_for_file: prefer_final_fields, unused_field, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables

import 'package:e_commerce/src/core/models/user_model.dart';
import 'package:e_commerce/src/core/preferences/user_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'dart:developer' as dev;

Map<String, dynamic> userData = {
  'id': null,
  'email': null,
  'wishlist': [],
  'favorites': [],
  'cart': [],
  'bought': [],
};

 CollectionReference userdb = FirebaseFirestore.instance.collection('users');

class UserController extends GetxController {
  final UserPreference _userPreference = UserPreference();

  Rxn<UserModel> _userModel = Rxn<UserModel>();

  User? _user;
  

  final FirebaseAuth _auth = FirebaseAuth.instance;


  UserController() {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        dev.log(user.uid);
      }
    });
    _auth.idTokenChanges().listen((User? user) {
      if (user != null) {
        dev.log(user.uid);
      }
    });
    _auth.userChanges().listen((User? user) {
      if (user != null) {
        dev.log(user.uid);
      }
    });
  }

  Future<int> registerWithEmailandPassword(
      String email, String password) async {
    int value;
    try {
      final UserCredential credential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // dev.log(credential.user!.metadata.toString());
      value = 1;
      _user = credential.user!;
      _userPreference.addUser(credential.user!);
      userData['id'] = _user?.uid;
      userData['email'] = _user?.email;
      userdb.doc(_user?.uid).set(userData);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        dev.log('The password provided is too weak.');
        value = 2;
      } else if (e.code == 'email-already-in-use') {
        dev.log('The account already exists for that email.');
        value = 3;
      } else if (e.code == 'network-request-failed') {
        dev.log('Please check the network connection.');
        value = 4;
      } else if (e.code == 'invalid-email') {
        dev.log(e.code);
        value = 5;
      } else {
        dev.log(e.code);
        value = 6;
      }
    }
    // dev.log(_user.toString());
    // dev.log(value.toString());
    return value;
  }

  Future<int> signInWithEmailandPassword(String email, String password) async {
    int value;
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      dev.log(credential.user!.metadata.toString());
      value = 1;
      _user = credential.user!;
      _userPreference.addUser(credential.user!);
      userData['id'] = _user?.uid;
      userData['email'] = _user?.email;
      // dev.log('db: ${userdb.doc().id}');
      // dev.log('user:$getUser');
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        dev.log('No user found for that email.');
        value = 2;
      } else if (e.code == 'wrong-password') {
        dev.log('Wrong password provided for that user.');
        value = 3;
      } else if (e.code == 'network-request-failed') {
        dev.log('Please check the network connection.');
        value = 4;
      } else {
        dev.log(e.code);
        value = 5;
      }
    }

    dev.log('value = $value');
    return value;
  }

  Future<int> signOut() async {
    int value;
    try {
      await FirebaseAuth.instance.signOut();
      value = 1;
      _userPreference.removeUser();
    } catch (e) {
      dev.log(e.toString());
      value = 0;
    }

    return value;
  }
  
  User? get getUser => _user;
}
