import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

mixin InputValidationMixin {
  bool isPasswordValid(String password) {
    if (password.length < 3) return false;
    return true;
  }

  bool isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(email);
  }

  bool isValidUsername(String username) {
    if (username.isEmpty) return false;
    return true;
  }
}
mixin FirebaseMixin {
  final _auth = FirebaseAuth.instance;

  Future<void> createUser(
      String email, String username, String password) async {
    final _resultAuth = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseFirestore.instance
        .collection("users")
        .doc(_resultAuth.user.uid)
        .set({"email": email, "password": password, "username": username});
  }

  Future<void> login(String email, String password) async {
    final _resultLogin = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    print('Result: ${_resultLogin.credential}');
  }
}
