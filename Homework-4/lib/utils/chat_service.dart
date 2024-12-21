import 'package:text_messaging/utils/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Send a message to a group chat
  Future<void> sendGroupMessage(String boardId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      chatName: boardId,
      message: message,
      timestamp: timestamp,
    );

    await _fireStore
        .collection('boards')
        .doc(boardId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // Retrieve messages from a group chat
  Stream<QuerySnapshot> getGroupMessages(String boardId) {
    return _fireStore
        .collection('boards')
        .doc(boardId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
