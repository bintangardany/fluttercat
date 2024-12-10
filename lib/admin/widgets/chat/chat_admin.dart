import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_service.dart';

class AdminChatListScreen extends StatefulWidget {
  const AdminChatListScreen({super.key});

  @override
  _AdminChatListScreenState createState() => _AdminChatListScreenState();
}

class _AdminChatListScreenState extends State<AdminChatListScreen> {
  final ChatService _chatService = ChatService();
  List<Map<String, dynamic>> _userChats = [];

  @override
  void initState() {
    super.initState();
    _fetchUserChats();
  }

  Future<void> _fetchUserChats() async {
    try {
      List<Map<String, dynamic>> userChats =
          await _chatService.getUsersForAdmin();
      setState(() {
        _userChats = userChats;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching chats: $e')),
      );
    }
  }

  void _navigateToChatDetail(Map<String, dynamic> user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminChatDetailScreen(
          userId: user['userId'],
          userEmail: user['email'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A1E9E),
        title: Text(
          'Admin Chat List',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _userChats.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
              itemCount: _userChats.length,
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey[300],
                thickness: 1.5, // Set thickness here
              ),
              itemBuilder: (context, index) {
                final user = _userChats[index];
                return ListTile(
                  onTap: () => _navigateToChatDetail(user),
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF4A1E9E),
                    child: Text(
                      user['email'][0].toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(user['email']),
                  subtitle: Text(user['role']),
                  trailing: user['unreadCount'] > 0
                      ? Badge(
                          label: Text(user['unreadCount'].toString()),
                          child: const Icon(Icons.chat_bubble),
                        )
                      : null,
                );
              },
            ),
    );
  }
}

class AdminChatDetailScreen extends StatefulWidget {
  final String userId;
  final String userEmail;

  const AdminChatDetailScreen(
      {super.key, required this.userId, required this.userEmail});

  @override
  _AdminChatDetailScreenState createState() => _AdminChatDetailScreenState();
}

class _AdminChatDetailScreenState extends State<AdminChatDetailScreen> {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _markMessagesAsRead();
  }

  Future<void> _markMessagesAsRead() async {
    try {
      await _chatService.markMessagesAsRead(
          widget.userId, FirebaseAuth.instance.currentUser?.uid ?? '');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to mark messages as read: $e')),
      );
    }
  }

  void _sendMessage() async {
    final message = _messageController.text.trim();

    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a message')),
      );
      return;
    }

    try {
      await _chatService.sendMessage(
        receiverId: widget.userId,
        message: message,
      );

      _messageController.clear();
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send message: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat with ${widget.userEmail}',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF4A1E9E),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _chatService.getChatStream(
                widget.userId,
                FirebaseAuth.instance.currentUser?.uid ?? '',
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                final messages = snapshot.data ?? [];
                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isSentByMe = message['senderId'] ==
                        FirebaseAuth.instance.currentUser?.uid;

                    final timestamp =
                        message['timestamp']?.toDate() ?? DateTime.now();
                    final timeFormatted =
                        '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';

                    return Column(
                      crossAxisAlignment: isSentByMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: isSentByMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: isSentByMe
                                  ? const Color(0xFF4A1E9E)
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              message['message'] ?? 'No message',
                              style: TextStyle(
                                color: isSentByMe ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          child: Text(
                            timeFormatted,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black54),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF4A1E9E)),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
