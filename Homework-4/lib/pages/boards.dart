import 'package:text_messaging/pages/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Boards extends StatefulWidget {
  const Boards({super.key});

  @override
  State<Boards> createState() => _BoardsState();
}

class _BoardsState extends State<Boards> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            "Chat Boards",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          backgroundColor: Colors.black,
        ),
        body: _buildBoardList());
  }

  Widget _buildBoardList() {
    String currentUserId = _auth.currentUser!.uid;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('boards')
            .where('memberIds', arrayContains: currentUserId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error', style: TextStyle(color: Colors.white));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text('No boards found',
                    style: TextStyle(color: Colors.white)));
          }

          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildBoardListItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildBoardListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(data['image']),
        backgroundColor: Colors.transparent,
      ),
      title: Text(
        data['name'],
        style: TextStyle(color: Colors.white),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                boardId: document.id,
              ),
            ));
      },
    );
  }
}
