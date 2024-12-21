import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  //sign in
  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //create a new user
  Future<UserCredential> signUpWithEmailandPassword(
      String email, password, username, firstName, lastName) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      String newUserId = userCredential.user!.uid;
      //After creating the user, create a new document for the user
      _fireStore.collection('users').doc(newUserId).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'role': "user",
        'boards': [],
        'bio': "",
        'dob': DateTime.now(),
        'registration_time': DateTime.now(),
      });
      // Add the user to all existing boards
      var boardQuerySnapshot = await _fireStore.collection('boards').get();
      List<String> boardIds = [];

      for (var board in boardQuerySnapshot.docs) {
        String boardId = board.id;
        boardIds.add(boardId);
        await _fireStore.collection('boards').doc(boardId).update({
          'memberIds': FieldValue.arrayUnion([newUserId])
        });
      }

      // Update user's board list
      await _fireStore
          .collection('users')
          .doc(newUserId)
          .update({'boards': boardIds});
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign out
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
