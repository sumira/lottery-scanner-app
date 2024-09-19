import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser(
      {required String email,
      required String password,
      required String name}) async {
    String res = "error occured in signup";
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestore.collection("users").doc(credential.user!.uid).set({
        'name': name,
        "email": email,
        'uid': credential.user!.uid,
      });
      res = "success";
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      String res = "error occured in signin";

      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
      return res;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
