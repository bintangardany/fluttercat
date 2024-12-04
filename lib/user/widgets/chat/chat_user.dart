import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chat_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String? _adminId;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeChatSession();
  }

  Future<void> _initializeChatSession() async {
    try {
      String? adminId = await _chatService.getAdminId();
      if (adminId == null) {
        setState(() {
          _errorMessage = 'No admin available for chat';
          _isLoading = false;
        });
        return;
      }

      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        setState(() {
          _errorMessage = 'No user is logged in';
          _isLoading = false;
        });
        return;
      }

      try {
        DocumentSnapshot senderDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (!senderDoc.exists) {
          setState(() {
            _errorMessage = 'User data not found';
            _isLoading = false;
          });
          return;
        }

        String senderRole = senderDoc['role'] ?? '';
        if (senderRole != 'user') {
          setState(() {
            _errorMessage = 'Only users can chat with admins';
            _isLoading = false;
          });
          return;
        }

        setState(() {
          _adminId = adminId;
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _errorMessage = 'Failed to fetch user data: ${e.toString()}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to initialize chat: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  void _sendMessage() async {
    final message = _messageController.text.trim();

    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Message cannot be empty')),
      );
      return;
    }

    if (_adminId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No admin available to chat with')),
      );
      return;
    }

    try {
      await _chatService.sendMessage(
        receiverId: _adminId!,
        message: message,
      );

      _messageController.clear();

      setState(() {});

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send message: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Chat')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Chat Error')),
        body: Center(
          child: Text(
            _errorMessage,
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with Admin', style: TextStyle(color: Colors.black)),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _chatService.getChatStream(
                  FirebaseAuth.instance.currentUser!.uid, _adminId!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No messages yet'));
                }

                final messages = snapshot.data!;
                return ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isSentByMe = message['senderId'] ==
                        FirebaseAuth.instance.currentUser!.uid;
                    final timestamp =
                        (message['timestamp'] as Timestamp?)?.toDate() ??
                            DateTime.now();

                    return Align(
                      alignment: isSentByMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: isSentByMe ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: isSentByMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              message['message'] ?? 'No message',
                              style: TextStyle(
                                color: isSentByMe ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                color: isSentByMe
                                    ? Colors.white70
                                    : Colors.black54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
