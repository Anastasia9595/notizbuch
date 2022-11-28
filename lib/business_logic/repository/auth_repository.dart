import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notizapp/business_logic/helpers/utils.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final userCollection = FirebaseFirestore.instance.collection('users');
  Future<UserCredential?> signUp({required String email, required String password}) async {
    try {
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Utils.showSnackbar('No user found for that email.');
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Utils.showSnackbar('Wrong password provided for that user.');
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception(e);
    }
  }

  // add user to firestore
  Future<void> addUserToFirestore(String name, String email, String id) async {
    try {
      final docUser = FirebaseFirestore.instance.collection('users').doc(id);
      await docUser.set({
        'name': name.trim(),
        'email': email.trim(),
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String?> fetchData(String data) async {
    final firebaseUser = await getUser();
    if (firebaseUser != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).get().then((value) {
          return value.data()![data];
        });
      } catch (e) {
        throw Exception(e);
      }
    }
    return null;
  }

  //get the current user
  Future<User?> getUser() async {
    try {
      return _firebaseAuth.currentUser;
    } catch (e) {
      throw Exception(e);
    }
  }
}
