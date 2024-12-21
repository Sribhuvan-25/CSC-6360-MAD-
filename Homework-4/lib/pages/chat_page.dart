import 'package:text_messaging/utils/chat_bubble.dart';
import 'package:text_messaging/utils/chat_service.dart';
import 'package:text_messaging/utils/text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final String boardId;
  const ChatPage({
    super.key,
    required this.boardId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<String> _getBoardName() async {
    var boardDocument =
        await _fireStore.collection('boards').doc(widget.boardId).get();
    if (boardDocument.exists) {
      return boardDocument.data()!['name'];
    } else {
      return 'Group Chat';
    }
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendGroupMessage(
          widget.boardId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: _getBoardName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading...", style: TextStyle(color: Colors.white));
            }
            if (snapshot.hasError) {
              return Text("Error", style: TextStyle(color: Colors.white));
            }
            return Text(
              snapshot.data ?? "Group Chat",
              style: TextStyle(color: Colors.white),
            );
          },
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  // Build message list for group chat
  Widget _buildMessageList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _chatService.getGroupMessages(widget.boardId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (!snapshot.hasData) {
          return const Text("No messages yet");
        }

        return ListView(
          children: snapshot.data!.docs.map((document) {
            return _buildMessageItem(document);
          }).toList(),
        );
      },
    );
  }

  // Build individual message item
  Widget _buildMessageItem(QueryDocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    Timestamp firestoreTimestamp = data["timestamp"];
    DateTime dateTime = firestoreTimestamp.toDate();
    String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(dateTime);

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(data['senderEmail']),
          const SizedBox(height: 5),
          Text(formattedDateTime),
          const SizedBox(height: 5),
          ChatBubble(
            message: data['message'],
            color: (data['senderId'] == _firebaseAuth.currentUser!.uid)
                ? Colors.blue
                : Colors.grey,
          ),
        ],
      ),
    );
  }

  // User input area
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              controller: _messageController,
              hintText: 'Enter message',
              obscureText: false,
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.send,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
