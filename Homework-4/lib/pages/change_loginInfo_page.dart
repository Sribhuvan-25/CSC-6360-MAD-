import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChangeLoginInfoPage extends StatefulWidget {
  @override
  _ChangeLoginInfoPageState createState() => _ChangeLoginInfoPageState();
}

class _ChangeLoginInfoPageState extends State<ChangeLoginInfoPage> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _updateEmail() async {
    String newEmail = _emailController.text.trim();
    User? user = _firebaseAuth.currentUser;

    if (newEmail.isNotEmpty && user != null) {
      try {
        await user.updateEmail(newEmail);
        await _firestore
            .collection('users')
            .doc(user.uid)
            .update({'email': newEmail});

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email updated successfully!')),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update email')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Login Information'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'New Email'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Update Email'),
              onPressed: _updateEmail,
            ),
          ],
        ),
      ),
    );
  }
}
