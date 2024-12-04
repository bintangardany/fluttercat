import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_service.dart';

class AdminChatScreen extends StatefulWidget {
  const AdminChatScreen({Key? key}) : super(key: key);

  @override
  _AdminChatScreenState createState() => _AdminChatScreenState();
}

class _AdminChatScreenState extends State<AdminChatScreen> {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String? _selectedUserId;
  String? _selectedUserEmail;
  List<Map<String, dynamic>> _userChats = [];

  @override
  void initState() {
    super.initState();
    _fetchUserChats();
  }

  Future<void> _fetchUserChats() async {
    try {
      List<Map<String, dynamic>> userChats = await _chatService.getUsersForAdmin();
      setState(() {
        _userChats = userChats;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching chats: $e')),
      );
    }
  }

  void _sendMessage() async {
    final message = _messageController.text.trim();

    if (message.isEmpty || _selectedUserId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select a user and enter a message')),
      );
      return;
    }

    try {
      await _chatService.sendMessage(
        receiverId: _selectedUserId!,
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

  void _showUserSelectionBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 400,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Select a User',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _userChats.length,
                  itemBuilder: (context, index) {
                    final user = _userChats[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(user['email'][0].toUpperCase()),
                      ),
                      title: Text('${user['email']}'),
                      subtitle: Text('${user['role']}'),
                      trailing: user['unreadCount'] > 0
                          ? Badge(
                              label: Text(user['unreadCount'].toString()),
                              child: const Icon(Icons.chat_bubble),
                            )
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedUserId = user['userId'];
                          _selectedUserEmail = user['email'];
                        });
                        Navigator.pop(context);
                        _chatService.markMessagesAsRead(
                          _selectedUserId!,
                          FirebaseAuth.instance.currentUser!.uid,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedUserEmail ?? 'Admin Support Chat'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.people),
            onPressed: _showUserSelectionBottomSheet,
          ),
        ],
      ),
      body: _selectedUserId == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.chat_bubble_outline, size: 100, color: Colors.grey),
                  const SizedBox(height: 20),
                  Text(
                    'Select a user to start chatting',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.people),
                    label: const Text('Select User'),
                    onPressed: _showUserSelectionBottomSheet,
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<Map<String, dynamic>>>( 
                    stream: _chatService.getChatStream(
                      _selectedUserId!,
                      FirebaseAuth.instance.currentUser?.uid ?? '',
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final messages = snapshot.data ?? [];
                      return ListView.builder(
                        controller: _scrollController,
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isSentByMe = message['senderId'] == FirebaseAuth.instance.currentUser?.uid;

                          return Align(
                            alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                              decoration: BoxDecoration(
                                color: isSentByMe ? Colors.blue[100] : Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    message['message'],
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  if (!isSentByMe)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        message['senderRole'] ?? '',
                                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FloatingActionButton(
                        onPressed: _sendMessage,
                        child: const Icon(Icons.send),
                        mini: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
