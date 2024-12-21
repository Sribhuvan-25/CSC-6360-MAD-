import 'package:text_messaging/pages/editProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final String _userId = FirebaseAuth.instance.currentUser!.uid;

  Future<Map<String, dynamic>> _getUserProfile() async {
    var userProfile = await _fireStore.collection('users').doc(_userId).get();
    return userProfile.data()!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading profile"));
          }
          var userData = snapshot.data!;
          return Column(
            children: [
              CircleAvatar(
                minRadius: 60,
                backgroundColor: Colors.red,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(userData['firstName'],
                      style: TextStyle(fontSize: 27, color: Colors.white)),
                  SizedBox(
                    width: 5,
                  ),
                  Text(userData['lastName'],
                      style: TextStyle(fontSize: 27, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => EditProfile()),
                        );
                      },
                      child: const Text("Edit Profile")),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
